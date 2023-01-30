# ddosakura/hakke:1.y.z-lit

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
