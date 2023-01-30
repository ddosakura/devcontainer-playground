FROM ddosakura/hakke:1.2.0-wasm

USER root
# tauri's dependencies
RUN <<EOT bash
  set -ex
  apt update
  apt install -y --no-install-recommends \
    libwebkit2gtk-4.0-dev \
    build-essential \
    libssl-dev \
    libgtk-3-dev \
    libayatana-appindicator3-dev \
    librsvg2-dev
  apt -y clean
  rm -rf /var/lib/apt/lists/*
EOT

USER vscode
