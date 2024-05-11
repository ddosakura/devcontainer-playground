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

实际使用优先参考 [all-in-one 开发容器搭建标准](https://github.com/ddosakura/PARA/blob/master/02%20Areas/开发规范/开发环境/all-in-one%20开发容器搭建标准.md)

## 镜像构建时相关项目最新版本

- node 使用 LTS 版本
- 仅 node & deno & bun & rust & protobuf 在构建脚本中指定了版本，其他集成以构建时实际安装的版本为准

```json
[
  [
    "microsoft/TypeScript",
    "v5.4.5"
  ],
  [
    "nodejs/node",
    "v20.12.2"
  ],
  [
    "denoland/deno",
    "v1.43.1"
  ],
  [
    "denoland/deno_std",
    "0.224.0"
  ],
  [
    "oven-sh/bun",
    "v1.1.7"
  ],
  [
    "rust-lang/rust",
    "1.78.0"
  ],
  [
    "jupyter/notebook",
    "v7.2.0rc0"
  ],
  [
    "WasmEdge/WasmEdge",
    "0.14.0-alpha.4"
  ],
  [
    "protocolbuffers/protobuf",
    "v26.1"
  ]
]
```

## Changelog

### v1.4.0

- 基于 ubuntu24.04 LTS 构建
  - ~~[For noble distro , the vscode user now points to uid:1001 and gid:1001](https://github.com/devcontainers/images/pull/1036)~~ 已在构建阶段移除，当前用户体系和之前已保持一致
  - Git 2.36+ 已支持 hasconfig:remote 配置（当前 git version 2.45.0）
- 升级了各运行时版本
- 默认集成 protobuf
- 将 deno&bun 全局安装路径写入 PATH
- 移除了 jupyter 集成

> [!tip] 为何移除 jupyter 集成，及安装方法
>
> https://pythonspeed.com/articles/externally-managed-environment-pep-668/#:~:text=If%20you%20wish%20to%20install,you%20have%20python3%2Dfull%20installed
>
> https://github.com/devcontainers/features/blob/main/src/python/install.sh
> ```bash
> install_user_package $INSTALL_UNDER_ROOT jupyterlab
> install_user_package $INSTALL_UNDER_ROOT jupyterlab-git
> ```
>
> https://jupyter.org/install
> https://docs.deno.com/runtime/manual/tools/jupyter
> https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter
> ```bash
> # pipx install jupyterlab # 只有 jupyter-lab 没有 jupyter 不满足 deno 的要求
> /usr/local/python/current/bin/python -m pip install --user --upgrade --no-cache-dir jupyterlab --break-system-packages
> jupyter lab
> deno jupyter --unstable --install
> ```

```
/usr/local/python/current/bin/python -m pip install --user --upgrade --no-cache-dir jupyterlab
error: externally-managed-environment

× This environment is externally managed
╰─> To install Python packages system-wide, try apt install
    python3-xyz, where xyz is the package you are trying to
    install.
    
    If you wish to install a non-Debian-packaged Python package,
    create a virtual environment using python3 -m venv path/to/venv.
    Then use path/to/venv/bin/python and path/to/venv/bin/pip. Make
    sure you have python3-full installed.
    
    If you wish to install a non-Debian packaged Python application,
    it may be easiest to use pipx install xyz, which will manage a
    virtual environment for you. Make sure you have pipx installed.
    
    See /usr/share/doc/python3.12/README.venv for more information.

note: If you believe this is a mistake, please contact your Python installation or OS distribution provider. You can override this, at the risk of breaking your Python installation or OS, by passing --break-system-packages.
hint: See PEP 668 for the detailed specification.
```

- versions
  - v1.4.0-lit
    - FROM ubuntu24.04
    - `wget` protobuf
    - `apt` direnv
    - `feature` github-cli/node
    - `feature/custom` deno
    - `feature/contrib/asdf` [bun-asdf](https://github.com/cometkim/asdf-bun)
  - v1.4.0-standard
    - FROM v1.4.0-lit
    - `feature` rust/python
  - v1.4.0-wasm
    - FROM v1.4.0-standard
    - `curl` wasmedge
  - ~~v1.4.0-desktop~~
    - 构建失败 - see: https://github.com/devcontainers/features/issues/968
    - FROM v1.4.0-wasm
    - `apt` tauri's dependencies
    - `feature` nix/desktop-lite

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
