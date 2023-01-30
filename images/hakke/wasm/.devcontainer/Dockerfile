FROM ddosakura/hakke:1.2.0-standard

USER root
RUN apt update \
  && apt install -y --no-install-recommends \
    clang \
  && apt -y clean \
  && rm -rf /var/lib/apt/lists/* \
  rustup target add wasm32-wasi
# https://wasmedge.org/book/en/quick_start/install.html
# This line installs WasmEdge including the AOT compiler
RUN curl -sSf https://raw.githubusercontent.com/WasmEdge/WasmEdge/master/utils/install.sh | bash -s -- -e all -p /usr/local

USER vscode
