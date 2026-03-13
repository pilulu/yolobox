# Security Model

## How It Works

yolobox uses **container isolation** (Docker or Podman) as its security boundary. When you run `yolobox`, it:

1. Starts a container with your project mounted at its real path
2. Runs as user `yolo` with sudo access *inside* the container
3. Does **not** mount your home directory (unless explicitly requested)
4. Uses Linux namespaces to isolate the container's filesystem, process tree, and network

The AI agent has full root access *inside the container*, but the container's view of the filesystem is restricted to what yolobox explicitly mounts.

## Trust Boundary

**The trust boundary is the container runtime** (Docker/Podman). This means:

- :white_check_mark: Protection against accidental `rm -rf ~` or credential theft
- :white_check_mark: Protection against most filesystem-based attacks
- :warning: **Not** protection against container escapes — a sufficiently advanced exploit targeting kernel vulnerabilities could break out
- :warning: **Not** protection against a malicious AI deliberately trying to escape — this is defense against accidents, not adversarial attacks

If you're worried about an AI actively trying to escape containment, you need VM-level isolation (see [Hardening Options](#hardening) below).

## Threat Model

### What yolobox protects

- Your home directory from accidental deletion
- Your SSH keys, credentials, and dotfiles
- Other projects on your machine
- Host system files and configurations

### What yolobox does NOT protect

- Your project directory (it's mounted read-write by default; use `--readonly-project` to change this)
- Network access (use `--no-network` to disable)
- The container itself (the AI has root via sudo)
- Against kernel exploits or container escape vulnerabilities

## Hardening Options {#hardening}

### Level 1: Basic (default)

```bash
yolobox claude
```

Standard container isolation. Good enough for most use cases.

### Level 2: Reduced attack surface

```bash
yolobox claude --no-network --readonly-project
```

No network access, read-only project. Outputs go to `/output`.

### Level 3: Rootless Podman

```bash
yolobox claude --runtime podman
```

Rootless Podman runs the container without root privileges on the host, using user namespaces. This significantly reduces the impact of container escapes since the container's "root" maps to your unprivileged user on the host.

::: tip Recommended for security-conscious users
Rootless Podman is the best balance of security and usability. No kernel-level attack surface from the container runtime, and no root daemon.
:::

### Level 4: VM isolation (maximum security)

For true isolation with no shared kernel:

- **macOS**: Use a Linux VM via UTM, Parallels, or Lima
- **Linux**: Use a Podman machine or dedicated VM

This adds significant overhead but eliminates kernel-level attack surface.

## Network Isolation with Podman

For users who want to prevent container access to the local network while preserving internet access:

```bash
# Rootless podman uses slirp4netns by default, which provides
# network isolation from the host network
podman run --network=slirp4netns:allow_host_loopback=false ...
```

yolobox doesn't currently expose this as a flag, but you can achieve it by running rootless Podman (the default network mode for rootless is slirp4netns).
