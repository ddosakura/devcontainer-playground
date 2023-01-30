# ddosakura/hakke:1.y.z-desktop

## nix

> [error: could not set permissions on '/nix/var/nix/profiles/per-user' to 755: Operation not permitted](https://github.com/NixOS/nix/issues/3435)

```bash
# https://github.com/devcontainers/features/tree/main/src/nix#manually-starting-the-nix-daemon
sudo /usr/local/share/nix-entrypoint.sh
```
