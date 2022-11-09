# https://github.com/denoland/deno_std/blob/main/.devcontainer/Dockerfile
# FROM --platform=linux/amd64 mcr.microsoft.com/vscode/devcontainers/base:0-bullseye
FROM --platform=linux/amd64 mcr.microsoft.com/devcontainers/base:1.0.0-ubuntu20.04

ENV DENO_INSTALL=/deno
RUN mkdir -p /deno \
    && curl -fsSL https://deno.land/x/install/install.sh | sh \
    && chown -R vscode /deno

ENV PATH=${DENO_INSTALL}/bin:${PATH} \
    DENO_DIR=${DENO_INSTALL}/.cache/deno
