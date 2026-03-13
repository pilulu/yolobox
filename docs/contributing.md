# Contributing

## Getting Started

```bash
git clone https://github.com/finbarr/yolobox.git
cd yolobox
make build
make test
```

## Requirements

- Go 1.22+
- Docker or Podman (for testing the container)

## Development

```bash
make build    # Build binary
make test     # Run tests
make lint     # Run linters
make image    # Build Docker image
make install  # Install to ~/.local/bin
```

## Code Style

- Follow standard Go conventions (`gofmt`, `go vet`)
- Keep the single-file design — don't split into packages unless absolutely necessary
- Add tests for new functionality

## Pull Requests

1. Fork the repo and create a branch
2. Make your changes
3. Run `make test` and `make lint`
4. Submit a PR with a clear description

## Reporting Issues

Include:
- OS and version
- Container runtime (Docker/Podman) and version
- Steps to reproduce
- Expected vs actual behavior

## Versioning

Version is derived automatically from git tags via `git describe`:
- Tagged commit: `v0.1.1`
- After tag: `v0.1.1-3-gead833b` (3 commits after tag)
- Uncommitted changes: adds `-dirty`

No files to edit for releases. The Makefile handles it.

## Releasing

```bash
git tag v0.1.2
git push origin master --tags
```

GitHub Actions automatically builds binaries for linux/darwin x amd64/arm64, creates a GitHub release, and pushes the Docker image to `ghcr.io/finbarr/yolobox`.

### Version Policy

- **Patch** (`0.1.x`): Bug fixes, security fixes
- **Minor** (`0.x.0`): New features
- **Major** (`x.0.0`): Breaking changes
