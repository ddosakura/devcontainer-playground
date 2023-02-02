FROM ddosakura/hakke:1.2.0-standard

USER root
RUN apt update \
  && apt install -y --no-install-recommends \
    clang \
  && apt -y clean \
  && rm -rf /var/lib/apt/lists/* \
  rustup target add wasm32-wasi
# https://wasmedge.org/book/en/quick_start/install.html
# This line installs WasmEdge including the AOT compiler (包含全部扩展及可用插件)
# https://wasmedge.org/book/en/plugin.html
# ERROR   - Plugin not compatible: manylinux2014x86_64wasi_nn-openvino
RUN curl -sSf https://raw.githubusercontent.com/WasmEdge/WasmEdge/master/utils/install.sh | bash -s -- -e all \
  --plugins wasi_nn-openvino wasi_crypto wasi_nn-pytorch wasi_nn-tensorflowlite wasmedge_httpsreq \
  -p /usr/local

USER vscode
