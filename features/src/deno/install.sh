export DENO_VERSION=${VERSION:-"latest"}
export DVM_DIR=${DVMINSTALLPATH:-"/usr/local/share/dvm"}

# TODO: fix  Permission denied
curl -fsSL https://deno.land/x/dvm/install.sh | sh

if [ "${NODE_VERSION}" = "latest" ]; then
  "$DVM_DIR/bin/dvm" install
elif [ "${DENO_VERSION}" != "none" ]; then
  "$DVM_DIR/bin/dvm" install $DENO_VERSION
fi

echo "Done!"
