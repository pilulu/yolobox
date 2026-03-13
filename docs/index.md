---
layout: home

hero:
  name: "yolobox"
  text: "Let your AI go full send. Your home directory stays home."
  tagline: Run Claude Code, Codex, or any AI coding agent in "yolo mode" without nuking your home directory.
  actions:
    - theme: brand
      text: Get Started
      link: /getting-started
    - theme: alt
      text: GitHub
      link: https://github.com/finbarr/yolobox

features:
  - title: Project mounted at its real path
    details: Your project directory is mounted read-write at its actual host path (e.g. /Users/you/project) for seamless session continuity.
  - title: Full permissions and sudo
    details: The agent has full root access inside the container. Need a compiler, database, or framework? It just installs it.
  - title: Home directory NOT mounted
    details: Your SSH keys, credentials, dotfiles, and other projects are never exposed — unless you explicitly opt in.
  - title: Persistent across sessions
    details: Named volumes keep tools, configs, and installations across runs. Setup happens once, not every time.
---

<HomeContent />
