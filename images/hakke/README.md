# ddosakura/hakke:1

## Quick Start

```json
{
  "name": "name_of_workspace",
  "image": "ddosakura/hakke:1.y.z-<version>",
  "postCreateCommand": "corepack enable && npm config set registry http://mirrors.tencent.com/npm/",
  "customizations": {
    "vscode": {
      "extensions": [
        "stylelint.vscode-stylelint",
        "antfu.unocss"
      ],
      "settings": {
        "editor.fontFamily": "Cascadia Code, Consolas, 'Courier New', monospace",
        "editor.fontLigatures": true
      }
    }
  }
}
```

## node/bun/deno/rust 版本

- https://nodejs.org/en/
- https://raw.githubusercontent.com/denoland/dotland/main/versions.json
- https://github.com/oven-sh/bun

## Changelog

### v1.2.0-ai

> 基于 lit 追加了 python 的版本

### v1.2.0+

> 自 1.1.0 加入 VNC 等功能后，镜像尺寸过大。
>
> 故根据使用频率、依赖关系及软件尺寸，拆分为多个版本的镜像。

- **x.y.x-lit** 小工具及最常用的开发工具
  - FROM ubuntu22.04
  - `apt` direnv
  - `feature` node
  - `vscode` dbaeumer.vscode-eslint
  - `feature` deno
  - `vscode` denoland.vscode-deno
  - `feature` github-cli
  - `vscode` eamodio.gitlens
- **x.y.x-standard** 添加 rust 工具链，基本对标 1.1.0 以前的无 VNC 环境
  - FROM x.y.x-lit
  - `feature` rust
  - `vscode` vadimcn.vscode-lldb
  - `vscode` mutantdino.resourcemonitor
  - `vscode` rust-lang.rust-analyzer
  - `vscode` tamasfe.even-better-toml
  - `vscode` serayuzgur.crates
- **x.y.x-wasm** wasm 开发支持（by rust）
  - FROM x.y.x-standard
  - `curl` wasmedge
- **x.y.x-desktop** VNC 支持、tauri 开发依赖及使用频率不高的工具
  - FROM x.y.x-wasm
  - `apt` tauri's dependencies
  - `feature` nix
  - `feature` desktop-lite

## Roadmap

### v1.3.0

- 升级了各运行时版本
- 增加新运行时
  bun，[该运行时暂无 bvm](https://github.com/oven-sh/bun/issues/3917)
- 鉴于
  [deno v1.37+ 的 Jupyter 集成，将 python 合并到 standard 版](https://deno.com/blog/v1.37)

- versions
  - v1.3.0-lit
    - FROM ubuntu22.04
    - `feature` github-cli/node
    - `feature/contrib` direnv/deno/
    - `feature/custom` [bun-asdf](https://github.com/cometkim/asdf-bun)
    - `vscode` eamodio.gitlens
    - `vscode` dbaeumer.vscode-eslint
    - `vscode` denoland.vscode-deno
    - `vscode` oven.bun-vscode
  - v1.3.0-standard
    - FROM v1.3.0-lit
    - `feature` rust/python
    - `vscode` vadimcn.vscode-lldb
    - `vscode` mutantdino.resourcemonitor
    - `vscode` rust-lang.rust-analyzer
    - `vscode` tamasfe.even-better-toml
    - `vscode` serayuzgur.crates
    - `vscode` ms-python.python
    - `vscode` ms-python.vscode-pylance
  - v1.3.0-wasm
    - FROM v1.3.0-standard
    - `curl` wasmedge
  - v1.3.0-wasm
    - FROM v1.3.0-standard
    - `curl` wasmedge
  - v1.3.0-desktop
    - FROM v1.3.0-wasm
    - `apt` tauri's dependencies
    - `feature` nix/desktop-lite

```jsonc
{
  // lit
  // standard
  // wasm
  // desktop
}
```

#### 调研

- https://github.com/devcontainers/features
- https://github.com/devcontainers-contrib/features
- https://github.com/jdx/rtx
  - https://github.com/cometkim/asdf-bun

## migrate from v0

migrate from https://github.com/ddosakura/nanami/blob/HEAD/hakke/Dockerfile

不再安装
[zx](https://www.google.com.hk/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjzioe-kaH7AhUh7XMBHaChA4oQFnoECAYQAQ&url=https%3A%2F%2Fgithub.com%2Fgoogle%2Fzx&usg=AOvVaw2W-PF0Jz1kvPSWz0llV21B)。

此外，需自行安装：

```bash
cargo install wasm-pack
# https://nodejs.org/dist/latest-v18.x/docs/api/corepack.html
corepack enable
```
