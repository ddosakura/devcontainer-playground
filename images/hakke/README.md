# ddosakura/hakke:1

migrate from https://github.com/ddosakura/nanami/blob/HEAD/hakke/Dockerfile

不再安装
[zx](https://www.google.com.hk/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjzioe-kaH7AhUh7XMBHaChA4oQFnoECAYQAQ&url=https%3A%2F%2Fgithub.com%2Fgoogle%2Fzx&usg=AOvVaw2W-PF0Jz1kvPSWz0llV21B)。

此外，需自行安装：

```bash
cargo install wasm-pack
# https://nodejs.org/dist/latest-v18.x/docs/api/corepack.html
corepack enable
```

## vscode 插件列表

- ddosakura/hakke
  - eamodio.gitlens
- [ghcr.io/devcontainers/features/rust:1](https://github.com/devcontainers/features/blob/main/src/rust/devcontainer-feature.json)
  - vadimcn.vscode-lldb
  - mutantdino.resourcemonitor
  - rust-lang.rust-analyzer
  - tamasfe.even-better-toml
  - serayuzgur.crates
- [ghcr.io/devcontainers/features/node:1](https://github.com/devcontainers/features/blob/main/src/node/devcontainer-feature.json)
  - dbaeumer.vscode-eslint
- [ghcr.io/ddosakura/devcontainer-playground/deno:0](../../features/src/deno/devcontainer-feature.json)
  - denoland.vscode-deno

## 环境变量的修正方案 (1.1.0 已集成 direnv)

```Dockerfile
FROM ddosakura/hakke:1.0.0

USER root
RUN apt-get update \
  && apt-get install -y direnv
# https://direnv.net/docs/hook.html
RUN echo "eval \"\$(direnv hook bash)\"" >> "/home/vscode/.bashrc"
RUN echo "eval \"\$(direnv hook zsh)\"" >> "/home/vscode/.zshrc"
# direnv allow

USER vscode
ENV DVM_DIR=/usr/local/share/dvm
ENV PATH="$DVM_DIR/bin:$PATH"
RUN dvm install ${DENO_VERSION}
# .envrc
# export DVM_DIR=/usr/local/share/dvm
# export PATH="$DVM_DIR/bin:$PATH"
```
