# devcontainer-playground

playground of
[VSCode Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)
with some images

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
echo $PAT | docker login ghcr.io --username ddosakura --password-stdin
devcontainer features publish features/src --namespace ddosakura/devcontainer-playground

cd images/hakke
devcontainer build --workspace-folder . --image-name ddosakura/hakke:1.0.0 .
docker push ddosakura/hakke:1.0.0
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
