# base image doc: https://github.com/devcontainers/images/blob/main/src/base-ubuntu/README.md
# tags: https://mcr.microsoft.com/v2/devcontainers/base/tags/list
FROM --platform=linux/amd64 mcr.microsoft.com/devcontainers/base:1.0.9-ubuntu22.04

USER root
RUN <<EOT bash
  set -ex
  apt-get update
  apt install -y --no-install-recommends \
    direnv
  apt -y clean
  rm -rf /var/lib/apt/lists/*
EOT

USER vscode
# https://direnv.net/docs/hook.html
RUN echo "eval \"\$(direnv hook bash)\"" >> "/home/vscode/.bashrc"
RUN echo "eval \"\$(direnv hook zsh)\"" >> "/home/vscode/.zshrc"
# need 'direnv allow' to use
