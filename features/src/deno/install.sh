export DENO_VERSION=${VERSION:-"latest"}
export DVM_DIR=${DVMINSTALLPATH:-"/usr/local/share/dvm"}

curl -fsSL https://deno.land/x/dvm/install.sh | sh
if [ "${DENO_VERSION}" != "" ]; then
  "$DVM_DIR/bin/dvm" install $DENO_VERSION
fi

echo "Done!"
