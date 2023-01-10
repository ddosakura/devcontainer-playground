# https://github.com/denoland/deno_std/blob/main/.devcontainer/Dockerfile
# FROM --platform=linux/amd64 mcr.microsoft.com/vscode/devcontainers/base:0-bullseye
FROM --platform=linux/amd64 mcr.microsoft.com/devcontainers/base:1.0.3-ubuntu22.04

ENV DENO_INSTALL=/deno
RUN mkdir -p /deno \
    && curl -fsSL https://deno.land/x/install/install.sh | sh \
    && chown -R vscode /deno

ENV PATH=${DENO_INSTALL}/bin:${PATH} \
    DENO_DIR=${DENO_INSTALL}/.cache/deno

# use mirrors.tencent.com
# RUN sed -i s@/archive.ubuntu.com/@/mirrors.tencent.com/@g /etc/apt/sources.list

# https://stackoverflow.com/questions/53950082/docker-images-lacking-tmp
# === bug in old version ===
# docker run -it --rm --user=vscode mcr.microsoft.com/devcontainers/base:1.0.0-ubuntu22.04 ls -al /tmp
# docker run -it --rm --user=vscode mcr.microsoft.com/devcontainers/base:1.0.3-ubuntu22.04 ls -al /tmp
# RUN chmod 1777 /tmp
