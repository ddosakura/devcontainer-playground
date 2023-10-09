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

## 镜像构建时相关项目最新版本

- node 使用 LTS 版本

```json
[
  [
    "microsoft/TypeScript",
    "v5.2.2"
  ],
  [
    "nodejs/node",
    "v18.18.0"
  ],
  [
    "denoland/deno",
    "v1.37.1"
  ],
  [
    "denoland/deno_std",
    "0.203.0"
  ],
  [
    "oven-sh/bun",
    "v1.0.4"
  ],
  [
    "rust-lang/rust",
    "1.73.0"
  ],
  [
    "jupyter/notebook",
    "v7.0.4"
  ],
  [
    "WasmEdge/WasmEdge",
    "0.13.4"
  ]
]
```

## Changelog

### v1.3.0

- 升级了各运行时版本
- 增加新运行时
  bun，[该运行时暂无 bvm](https://github.com/oven-sh/bun/issues/3917)
- 鉴于 [deno v1.37+ 的 Jupyter 集成](https://deno.com/blog/v1.37)，将 python
  合并到 standard 版

```bash
deno jupyter --unstable
```

- 鉴于
  [devcontainers-contrib/features](https://github.com/devcontainers-contrib/features/blob/main/src/direnv/README.md)
  中的 direnv 不包含 bash/zsh 集成，依旧使用旧有方法添加

- versions
  - v1.3.0-lit
    - FROM ubuntu22.04
    - ~~`feature/contrib`~~ `apt` direnv
    - `feature` github-cli/node
    - `feature/custom` deno
    - `feature/contrib/asdf` [bun-asdf](https://github.com/cometkim/asdf-bun)
  - v1.3.0-standard
    - FROM v1.3.0-lit
    - `feature` rust/python
  - v1.3.0-wasm
    - FROM v1.3.0-standard
    - `curl` wasmedge
  - v1.3.0-desktop
    - FROM v1.3.0-wasm
    - `apt` tauri's dependencies
    - `feature` nix/desktop-lite

推荐扩展：

```jsonc
{
  "recommendations": [
    // useful
    "antfu.unocss",
    "antfu.iconify",
    "antfu.goto-alias",
    "csstools.postcss",
    "svelte.svelte-vscode",
    "vue.volar",
    "Vue.vscode-typescript-vue-plugin",
    "astro-build.astro-vscode",
    "bierner.markdown-mermaid",
    "unifiedjs.vscode-mdx",
    "windmill-labs.windmill",
    // standard
    // "ms-python.python",
    // "ms-python.vscode-pylance",
    "vadimcn.vscode-lldb",
    "mutantdino.resourcemonitor",
    "rust-lang.rust-analyzer",
    "tamasfe.even-better-toml",
    "serayuzgur.crates",
    // lit
    "oven.bun-vscode",
    "dbaeumer.vscode-eslint",
    "denoland.vscode-deno",
    // "dprint.dprint",
    "eamodio.gitlens"
  ]
}
```

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

> NEXT v1.4.0

- 升级 ubuntu24.04 LTS
- 调研 asdf 的 替代品 [rtx](https://github.com/jdx/rtx)
- 将 deno 全局安装路径写入 PATH

```bash
# echo "export PATH=\"/home/vscode/.deno/bin:\$PATH\"" >> "/home/vscode/.bashrc"
# echo "export PATH=\"/home/vscode/.deno/bin:\$PATH\"" >> "/home/vscode/.zshrc"

# https://github.com/microsoft/vscode-remote-release/issues/2324
# in Dockerfile
# ENV PATH=/home/vscode/.deno/bin:$PATH
```

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
