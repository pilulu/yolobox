# Commands

## Philosophy: It's the AI's Box, Not Yours

yolobox is designed for AI agents, not humans. You launch the AI and let it work. You're not meant to manually enter the box and set things up — the AI does that itself.

The AI agent has full sudo access inside the container. If it needs a compiler, database, or framework — it just installs it. Named volumes persist these installations across sessions, so setup happens once. You point it at your project and let it cook.

## Command Reference

```bash
# AI tool shortcuts (recommended)
yolobox claude              # Run Claude Code
yolobox codex               # Run OpenAI Codex
yolobox gemini              # Run Gemini CLI
yolobox opencode            # Run OpenCode
yolobox copilot             # Run GitHub Copilot

# General commands
yolobox                     # Drop into interactive shell
yolobox run <cmd...>        # Run any command in sandbox
yolobox setup               # Configure yolobox settings
yolobox upgrade             # Update binary and pull latest image
yolobox config              # Show resolved configuration
yolobox reset --force       # Delete volumes (fresh start)
yolobox version             # Show version
yolobox help                # Show help
```

## Examples

Run Claude Code with Docker access and your git config:

```bash
yolobox claude --docker --git-config --gh-token
```

Run a command in a sandboxed, network-isolated environment:

```bash
yolobox run --no-network --readonly-project python3 untrusted_script.py
```

Start fresh (wipe all persistent volumes):

```bash
yolobox reset --force
```
