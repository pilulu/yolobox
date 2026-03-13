# What's in the Box

The base image comes batteries-included so AI agents can start working immediately.

## Pre-installed Tools

### AI CLIs
- **Claude Code** — Anthropic's coding agent
- **Gemini CLI** — Google's coding agent
- **OpenAI Codex** — OpenAI's coding agent
- **OpenCode** — Open-source coding agent
- **GitHub Copilot** — GitHub's coding agent

### Runtimes
- **Node.js 22** + npm
- **Python 3** + pip
- **Go**
- **Bun**

### Build Tools
- make, cmake, gcc

### Utilities
- **git** + **GitHub CLI** (`gh`)
- **ripgrep** (`rg`) — fast grep replacement
- **fd** — fast find replacement
- **fzf** — fuzzy finder
- **bat** — cat with syntax highlighting
- **eza** — modern ls replacement
- **jq** — JSON processor
- **vim**
- **uv** — fast Python package manager

Need something else? The AI has sudo — it can install anything.

## YOLO Mode

Inside yolobox, AI CLIs are aliased to skip all permission prompts:

| Command | Expands to |
|---------|------------|
| `claude` | `claude --dangerously-skip-permissions` |
| `codex` | `codex --dangerously-bypass-approvals-and-sandbox` |
| `gemini` | `gemini --yolo` |
| `opencode` | `opencode` |
| `copilot` | `copilot --yolo` |

No confirmations, no guardrails — just pure unfiltered AI. That's the point.

::: tip Why is this safe?
The AI is running inside a container. It can `rm -rf /` and the only thing destroyed is the container itself. Your home directory, your SSH keys, your other projects — all untouched.
:::
