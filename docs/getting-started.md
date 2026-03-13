# Installation & Setup

## Install

### Homebrew (macOS/Linux)

```bash
brew install finbarr/tap/yolobox
```

### Install script (requires Go)

```bash
curl -fsSL https://raw.githubusercontent.com/finbarr/yolobox/master/install.sh | bash
```

## Your First Run

```bash
cd /path/to/your/project
yolobox claude
```

That's it. yolobox launches Claude Code inside a container with your project mounted. The AI has full permissions inside the sandbox — your home directory is never exposed.

You can also use any other AI tool:

```bash
yolobox codex     # OpenAI Codex
yolobox gemini    # Gemini CLI
yolobox opencode  # OpenCode
yolobox copilot   # GitHub Copilot
```

Or drop into a shell for manual use:

```bash
yolobox           # Interactive shell
yolobox run echo "hello"   # Run any command
```

## Runtime Support

yolobox supports multiple container runtimes and auto-detects what's available:

| Platform | Supported Runtimes |
|---|---|
| **macOS** | Docker Desktop, OrbStack, Colima, Apple container (macOS Tahoe+) |
| **Linux** | Docker, Podman |

To use a specific runtime:

```bash
yolobox claude --runtime container   # Apple container
yolobox claude --runtime docker      # Docker
yolobox claude --runtime podman      # Podman
```

::: warning Memory Requirements
Claude Code needs **4GB+ RAM** allocated to Docker. Colima defaults to 2GB which will cause OOM kills. Increase with:
```bash
colima stop && colima start --memory 8
```
:::
