# Flags

::: tip
Flags go **after** the subcommand: `yolobox run --flag cmd` or `yolobox claude --flag`, not `yolobox --flag run cmd`.
:::

## Flag Reference

| Flag | Description |
|------|-------------|
| `--runtime <name>` | Use `docker`, `podman`, or `container` (Apple) |
| `--image <name>` | Custom base image |
| `--mount <src:dst>` | Extra mount (repeatable) |
| `--env <KEY=val>` | Set environment variable (repeatable) |
| `--setup` | Run interactive setup before starting |
| `--ssh-agent` | Forward SSH agent socket |
| `--no-network` | Disable network access |
| `--network <name>` | Join specific network (e.g., docker compose) |
| `--pod <name>` | Join existing Podman pod (shares its network) |
| `--no-yolo` | Disable auto-confirmations (mindful mode) |
| `--scratch` | Start with a fresh home/cache (nothing persists) |
| `--readonly-project` | Mount project read-only (outputs go to `/output`) |
| `--claude-config` | Copy host `~/.claude` config into container |
| `--gemini-config` | Copy host `~/.gemini` config into container |
| `--git-config` | Copy host `~/.gitconfig` into container |
| `--gh-token` | Forward GitHub CLI token (extracts from keychain via `gh auth token`) |
| `--copy-agent-instructions` | Copy global agent instruction files ([details](/configuration#global-agent-instructions)) |
| `--docker` | Mount Docker socket and join shared network ([details](#docker-access)) |
| `--cpus <num>` | Limit CPUs (accepts fractions like `3.5`) |
| `--memory <limit>` | Hard memory limit (e.g., `8g`, `1024m`) |
| `--shm-size <size>` | Size of `/dev/shm` tmpfs (useful for browsers/playwright) |
| `--gpus <spec>` | Pass GPUs (e.g., `all`, `device=0`) |
| `--device <src:dest>` | Add host devices in the container (repeatable) |
| `--cap-add <cap>` | Add Linux capabilities (repeatable) |
| `--cap-drop <cap>` | Drop Linux capabilities (repeatable) |
| `--runtime-arg <flag>` | Pass raw runtime flags directly to Docker/Podman (repeatable) |

## SSH Agent (macOS) {#ssh-agent}

On macOS, `--ssh-agent` requires the Docker VM to forward the SSH agent:

- **Docker Desktop**: forwards the agent automatically.
- **Colima**: edit `~/.colima/default/colima.yaml`, set `forwardAgent: true`, then restart (`colima stop && colima start`).

## Networking {#networking}

By default, yolobox uses Docker's bridge network (internet access, no container DNS).

- `--network <name>` — join a docker compose network and access services by name.
- `--no-network` — complete network isolation (no internet, no LAN).

## Docker Access {#docker-access}

The `--docker` flag mounts the host Docker socket into the container and joins a shared `yolobox-net` network. This lets the AI agent:

- Run Docker commands (build images, start containers, use docker compose)
- Create sibling containers on the same network
- Communicate with services by container name

The network name is available inside the container as `$YOLOBOX_NETWORK`.

::: warning
`--docker` cannot be used with `--no-network`.
:::

## Resource & Security Controls {#advanced}

The flags table covers the common knobs baked into yolobox. Anything else (e.g., `--ulimit nofile=4096:8192`, `--security-opt seccomp=unconfined`) can be forwarded verbatim with `--runtime-arg`:

```bash
yolobox run \
  --runtime-arg "--ulimit" \
  --runtime-arg "nofile=4096:8192" \
  --runtime-arg "--security-opt" \
  --runtime-arg "seccomp=unconfined" \
  claude
```

Docker and Podman accept these flags unchanged. Apple's `container` runtime ignores options it doesn't understand.
