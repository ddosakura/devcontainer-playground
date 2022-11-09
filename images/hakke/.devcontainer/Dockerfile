FROM --platform=linux/amd64 mcr.microsoft.com/devcontainers/base:1.0.0-ubuntu20.04

# https://deno.land/
ARG DENO_VERSION=1.27.2
# https://www.denojs.cn/manual/getting_started/installation
# https://github.com/justjavac/dvm
# https://raw.githubusercontent.com/denoland/dotland/main/versions.json
RUN curl -fsSL https://deno.land/x/dvm/install.sh | sh
RUN /bin/bash -c "source $HOME/.bash_profile && dvm install $DENO_VERSION"
