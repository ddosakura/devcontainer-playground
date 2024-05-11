# base image doc: https://github.com/devcontainers/images/blob/main/src/base-ubuntu/README.md
# tags: https://mcr.microsoft.com/v2/devcontainers/base/tags/list
FROM --platform=linux/amd64 mcr.microsoft.com/devcontainers/base:1.1.0-ubuntu24.04

# https://github.com/devcontainers/images/issues/1056
# 保留 ubuntu 会破坏很多既有工具链，同时造成无法在默认设置下编辑仓库代码等一系列问题
# 在无更好的解决方案前，将用户环境调整为之前的状态
RUN userdel -r ubuntu
RUN usermod -u 1000 vscode
RUN groupmod -g 1000 vscode

# protobuf
# https://typonotes.com/posts/2023/09/03/dockerfile-buildkit-here-syntax-wonderful/#troubleshooting
# RUN <<EOT
# #!/bin/bash
# set -exu
# mkdir tmp_protoc
# cd tmp_protoc
# wget https://github.com/protocolbuffers/protobuf/releases/download/v26.1/protoc-26.1-linux-x86_64.zip
# unzip protoc-26.1-linux-x86_64.zip
# mv include/google /usr/local/include/
# mv bin/protoc /usr/local/bin/
# rm protoc-26.1-linux-x86_64.zip
# cd ..
# rm -rf tmp_protoc
# EOT
WORKDIR /usr/local
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v26.1/protoc-26.1-linux-x86_64.zip
RUN unzip protoc-26.1-linux-x86_64.zip
RUN rm protoc-26.1-linux-x86_64.zip readme.txt
WORKDIR /

# https://github.com/woodongwong/notes/issues/9
RUN <<EOT bash
  set -exu
  apt-get update
  apt-get install -y --no-install-recommends \
    direnv
  apt-get -y clean
  rm -rf /var/lib/apt/lists/*
EOT
# RUN apt-get update
# RUN apt-get install -y --no-install-recommends direnv
# RUN apt-get clean
# RUN rm -rf /var/lib/apt/lists/*

USER vscode

# https://direnv.net/docs/hook.html
RUN echo "eval \"\$(direnv hook bash)\"" >> "/home/vscode/.bashrc"
RUN echo "eval \"\$(direnv hook zsh)\"" >> "/home/vscode/.zshrc"
# need 'direnv allow' to use

# https://github.com/microsoft/vscode-remote-release/issues/2324
ENV PATH=/home/vscode/.deno/bin:$PATH
ENV PATH=/home/vscode/.bun/bin:$PATH
