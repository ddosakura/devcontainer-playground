# devcontainer-playground

playground of
[VSCode Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)
with some images

**开发容器需要有个非 root 用户 e.g. uid/gid=1000**
~~需要能挂载 `/var/run/docker.sock`~~

- .devcontainer **VSCode Dev Containers**
- .docker **Docker Dev Environments**
- .vscode **VSCode Configuration**
- [open dev container specification](https://containers.dev)

## Images & Templates

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

## Notes

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
