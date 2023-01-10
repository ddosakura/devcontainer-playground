FROM --platform=linux/amd64 mcr.microsoft.com/devcontainers/base:1.0.3-ubuntu22.04

USER root
RUN apt update \
  && apt install -y --no-install-recommends direnv \
    ### tauri's dependencies
    libwebkit2gtk-4.0-dev \
    build-essential \
    # curl \
    # wget \
    libssl-dev \
    libgtk-3-dev \
    libayatana-appindicator3-dev \
    librsvg2-dev \
  && apt -y clean \
  && rm -rf /var/lib/apt/lists/*

USER vscode
# https://direnv.net/docs/hook.html
RUN echo "eval \"\$(direnv hook bash)\"" >> "/home/vscode/.bashrc"
RUN echo "eval \"\$(direnv hook zsh)\"" >> "/home/vscode/.zshrc"
# need 'direnv allow' to use
