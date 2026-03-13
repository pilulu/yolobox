# Configuration

## Interactive Setup

Run `yolobox setup` to configure your preferences with an interactive wizard. Settings are saved to `~/.config/yolobox/config.toml`.

## Config Files

### Global config (`~/.config/yolobox/config.toml`)

Applies to all projects:

```toml
git_config = true
gh_token = true
ssh_agent = true
docker = true
no_network = true
network = "my_compose_network"
no_yolo = true
cpus = "4"
memory = "8g"
cap_add = ["SYS_PTRACE"]
devices = ["/dev/kvm:/dev/kvm"]
runtime_args = ["--security-opt", "seccomp=unconfined"]
```

### Project config (`.yolobox.toml`)

Place in your project root for project-specific settings:

```toml
mounts = ["../shared-libs:/libs:ro"]
env = ["DEBUG=1"]
no_network = true
shm_size = "2g"
```

### Precedence

**CLI flags > project config > global config > defaults**

## Runtime Args Format

Each `runtime_args` entry is a single CLI argument. For flags that take a value, add them as separate entries:

```toml
# --security-opt seccomp=unconfined becomes:
runtime_args = ["--security-opt", "seccomp=unconfined"]
```

## Global Agent Instructions {#global-agent-instructions}

The `--copy-agent-instructions` flag copies your global/user-level agent instruction files into the container. Useful when you have custom rules or preferences defined globally.

Files copied (if they exist on your host):

| Tool | Source | Destination |
|------|--------|-------------|
| Claude | `~/.claude/CLAUDE.md` | `/home/yolo/.claude/CLAUDE.md` |
| Gemini | `~/.gemini/GEMINI.md` | `/home/yolo/.gemini/GEMINI.md` |
| Codex | `~/.codex/AGENTS.md` | `/home/yolo/.codex/AGENTS.md` |
| Copilot | `~/.copilot/agents/` | `/home/yolo/.copilot/agents/` |

This only copies instruction files, not full configs (credentials, settings, history). For Claude's full config, use `--claude-config` instead.

Set `copy_agent_instructions = true` in your config file for persistent use.

## Auto-Forwarded Environment Variables

These are automatically passed into the container if set on the host:

- `ANTHROPIC_API_KEY`
- `OPENAI_API_KEY`
- `COPILOT_GITHUB_TOKEN` / `GH_TOKEN` / `GITHUB_TOKEN`
- `OPENROUTER_API_KEY`
- `GEMINI_API_KEY`

::: tip macOS and GitHub tokens
On macOS, `gh` CLI stores tokens in Keychain, not environment variables. Use `--gh-token` (or `gh_token = true` in config) to extract and forward your GitHub CLI token.
:::

## Config Sync Warning

::: warning
Setting `claude_config = true` or `gemini_config = true` in your config will copy your host config on **every** container start, overwriting any changes made inside the container (including auth and history). Prefer using `--claude-config` or `--gemini-config` as one-time flags.
:::
