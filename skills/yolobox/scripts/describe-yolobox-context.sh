#!/bin/bash
set -euo pipefail

context_file="${YOLOBOX_CONTEXT_FILE:-/run/yolobox/context.json}"

usage() {
    cat <<'EOF'
Usage: describe-yolobox-context.sh [--json]

Describe the current yolobox session.

Options:
  --json    Print the raw yolobox context manifest when available
  --help    Show this help text
EOF
}

case "${1:-}" in
    --help)
        usage
        exit 0
        ;;
    --json)
        ;;
    "")
        ;;
    *)
        printf 'Error: unknown option: %s\n\n' "${1:-}" >&2
        usage >&2
        exit 1
        ;;
esac

if [[ "${1:-}" == "--json" ]]; then
    if [[ -f "$context_file" ]]; then
        cat "$context_file"
    else
        inside_json="false"
        if [[ "${YOLOBOX:-}" == "1" ]]; then
            inside_json="true"
        fi
        printf '{\n  "inside_yolobox": %s,\n  "manifest_present": false\n}\n' "$inside_json"
    fi
    exit 0
fi

if [[ -f "$context_file" ]] && command -v jq >/dev/null 2>&1; then
    jq -r '
        [
            "Inside yolobox: yes",
            "Source: manifest",
            "Project: " + .paths.project,
            "Workdir: " + .launch.working_dir,
            "Home: " + .paths.home,
            (if .paths.output != null and .paths.output != "" then "Output: " + .paths.output else empty end),
            "Runtime: configured=" + .runtime.configured + " selected=" + .runtime.selected,
            "Interactive: " + (.launch.interactive | tostring),
            "Readonly project: " + (.config.readonly_project | tostring),
            "Scratch: " + (.config.scratch | tostring),
            "No network: " + (.config.no_network | tostring),
            (if .config.network != "" then "Network: " + .config.network else empty end),
            (if .config.pod != "" then "Pod: " + .config.pod else empty end),
            "Docker socket: " + (.config.docker | tostring),
            "SSH agent: " + (.config.ssh_agent | tostring),
            "YOLO wrappers disabled: " + (.config.no_yolo | tostring),
            (if (.config.customize.packages | length) > 0 then "Customize packages: " + (.config.customize.packages | join(", ")) else empty end),
            (if .config.customize.dockerfile != "" then "Customize dockerfile: " + .config.customize.dockerfile else empty end),
            (if (.launch.auto_passthrough_env_keys | length) > 0 then "Auto-forwarded env keys: " + (.launch.auto_passthrough_env_keys | join(", ")) else empty end),
            (if (.config.env_keys | length) > 0 then "Explicit env keys: " + (.config.env_keys | join(", ")) else empty end)
        ]
        | .[]
    ' "$context_file"
    exit 0
fi

inside="no"
if [[ "${YOLOBOX:-}" == "1" ]]; then
    inside="yes"
fi

project="${YOLOBOX_PROJECT_PATH:-$(pwd)}"
workdir="$(pwd)"
home_dir="${HOME:-/home/yolo}"
readonly_project="false"
output_path=""
docker_socket="false"
ssh_agent="false"

if [[ -d /output ]]; then
    readonly_project="true"
    output_path="/output"
fi
if [[ -S /var/run/docker.sock ]]; then
    docker_socket="true"
fi
if [[ -n "${SSH_AUTH_SOCK:-}" && -S "${SSH_AUTH_SOCK}" ]]; then
    ssh_agent="true"
fi

printf 'Inside yolobox: %s\n' "$inside"
printf 'Source: inferred (manifest unavailable)\n'
printf 'Project: %s\n' "$project"
printf 'Workdir: %s\n' "$workdir"
printf 'Home: %s\n' "$home_dir"
if [[ -n "$output_path" ]]; then
    printf 'Output: %s\n' "$output_path"
fi
printf 'Readonly project: %s\n' "$readonly_project"
printf 'Docker socket: %s\n' "$docker_socket"
printf 'SSH agent: %s\n' "$ssh_agent"
