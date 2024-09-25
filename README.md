# devcontainer-playground

playground of
[VSCode Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)
with some images

## 开发常见环境问题及解决方案

### 开发容器设置代理以安装 vscode 插件 `vadimcn.vscode-lldb`

```bash
# write to /home/vscode/.profile

KCP_HOST=
# export HTTP_PROXY=socks5://$KCP_HOST:29980
# export HTTPS_PROXY=socks5://$KCP_HOST:29980
export HTTP_PROXY=http://$KCP_HOST:29981
export HTTPS_PROXY=http://$KCP_HOST:29981
export NO_PROXY=$KCP_HOST,::1,localhost

# 无代理主要影响 github 的使用 e.g.
# https://github.com/vadimcn/vscode-lldb/releases/download/v1.8.1/codelldb-x86_64-linux.vsix
# https://raw.githubusercontent.com/denoland/deno/main/cli/schemas/config-file.v1.json
```

### 需要 root 用户执行软件安装等操作

```bash
docker exec -ti <id> /bin/bash
apt update
```

## tips

**开发容器需要有个非 root 用户 e.g. uid/gid=1000**

**~~需要能挂载 `/var/run/docker.sock`~~**

- .devcontainer **VSCode Dev Containers**
- .docker **Docker Dev Environments**
- .vscode **VSCode Configuration**
- [open dev container specification](https://containers.dev)

## docker images

- features
  - deno
- images
  - hakke **rust|node|deno 集成镜像**

## official images、features & templates

- [old repo](https://github.com/microsoft/vscode-dev-containers)
- [images](https://github.com/devcontainers/images)
- [features](https://github.com/devcontainers/features) e.g. Docker-from-Docke
- [templates](https://containers.dev/templates)
- [🐳 Extra add-in features for Devcontainers and GitHub Codespaces](https://github.com/devcontainers-contrib/features)

```json
{
  "image": "mcr.microsoft.com/vscode/devcontainers/base:0-bullseye",
  "dockerFile": "Dockerfile",
  "build": { "dockerfile": "Dockerfile" },
  "tips": "三选一"
}
```

## notes

- [cli](https://github.com/devcontainers/cli)

```bash
# # run by bun 存在问题，用不了
# bun install -g @devcontainers/cli
# bunx devcontainer

# by dind
# bunp () {
#   docker run \
#     --interactive \
#     --tty \
#     --rm \
#     -v /var/run/docker.sock:/var/run/docker.sock \
#     -v $PWD:$PWD \
#     --workdir $PWD \
#     -p $PORT:$PORT \
#     ddosakura/dind:26.0.0-bun1.0.36 \
#     "$@"
# }
PORT=6969 bunp /bin/bash

# 一键启动环境
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock -v $PWD:$PWD --workdir $PWD ddosakura/dind:26.0.0-bun1.0.36 /bin/bash

# https://nodejs.org/en/download/package-manager
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 20
npm install -g @devcontainers/cli
apt update
# 注意，没有 buildx 的情况下 devcontainer 会回退到使用 build，此时无法解析 `RUN <<EOT` 脚本
apt install docker-buildx-plugin
```

```bash
echo $PAT | docker login ghcr.io --username ddosakura --password-stdin
devcontainer features publish features/src --namespace ddosakura/devcontainer-playground
```

```bash
###cd images/hakke
###devcontainer build --workspace-folder . --image-name ddosakura/hakke:1.1.0 .
cd images/hakke/lit
devcontainer build --workspace-folder . --image-name ddosakura/hakke:1.4.0-lit .
cd ../standard
devcontainer build --workspace-folder . --image-name ddosakura/hakke:1.4.0-standard .
docker tag ddosakura/hakke:1.4.0-standard ddosakura/hakke:1.4.0
cd ../wasm
devcontainer build --workspace-folder . --image-name ddosakura/hakke:1.4.0-wasm .
cd ../desktop
devcontainer build --workspace-folder . --image-name ddosakura/hakke:1.4.0-desktop .

# 需要代理时使用
docker buildx build --build-arg HTTP_PROXY=http://host.docker.internal:7890 --build-arg HTTPS_PROXY=http://host.docker.internal:7890 --load --build-arg BUILDKIT_INLINE_CACHE=1 -f /tmp/devcontainercli-vscode/container-features/0.35.0-1680205465545/Dockerfile-with-features -t ddosakura/hakke:1.4.0-ai --target dev_containers_target_stage --build-context dev_containers_feature_content_source=/tmp/devcontainercli-vscode/container-features/0.35.0-1680205465545 --build-arg _DEV_CONTAINERS_BASE_IMAGE=dev_container_auto_added_stage_label --build-arg _DEV_CONTAINERS_IMAGE_USER=vscode --build-arg _DEV_CONTAINERS_FEATURE_CONTENT_SOURCE=dev_container_feature_content_temp /workspaces/devcontainer-playground/images/hakke/ai/.devcontainer

docker push ddosakura/hakke:1.4.0-lit
docker push ddosakura/hakke:1.4.0-standard
docker push ddosakura/hakke:1.4.0
docker push ddosakura/hakke:1.4.0-wasm
docker push ddosakura/hakke:1.4.0-desktop
```

- [devcontainer.json](https://containers.dev/implementors/json_reference)

- https://code.visualstudio.com/docs/devcontainers/containers#_sharing-git-credentials-with-your-container

```bash
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

> extension will automatically copy your local .gitconfig file into the
> container on startup

- https://code.visualstudio.com/docs/devcontainers/containers#_personalizing-with-dotfile-repositories
  - https://dotfiles.github.io/

### errors

- curl
  - https://serverfault.com/questions/1083999/curl-35-ssl-received-a-record-that-exceeded-the-maximum-permissible-length
  - https://stackoverflow.com/questions/50840101/curl-35-error1408f10bssl-routinesssl3-get-recordwrong-version-number
  - https://stackoverflow.com/questions/49111984/docker-container-cant-curl-ssl-wrong-version-number
  - ~~curl 指定 443 端口有时可以规避报错~~
