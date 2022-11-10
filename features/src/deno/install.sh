export DENO_VERSION=${VERSION:-"latest"}
export DVM_DIR=${DVMINSTALLPATH:-"/usr/local/share/dvm"}

USERNAME=${USERNAME:-"root"}

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

apt_get_update() {
    if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
        echo "Running apt-get update..."
        apt-get update -y
    fi
}

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        apt_get_update
        apt-get -y install --no-install-recommends "$@"
    fi
}

# Install dependencies
check_packages apt-transport-https curl ca-certificates unzip

# Install snipppet that we will run as the user
dvm_install_snippet="$(cat << EOF
set -e
umask 0002
curl -fsSL https://deno.land/x/dvm@v1.8.6/install.sh | sh
if [ "${DENO_VERSION}" = "latest" ]; then
  "$DVM_DIR/bin/dvm" install
elif [ "${DENO_VERSION}" != "none" ]; then
  "$DVM_DIR/bin/dvm" install $DENO_VERSION
fi
EOF
)"

# Create dvm group to the user's UID or GID to change while still allowing access to dvm
if ! cat /etc/group | grep -e "^dvm:" > /dev/null 2>&1; then
    groupadd -r dvm
fi
usermod -a -G dvm ${USERNAME}

# Install dvm
umask 0002
if [ ! -d "${DVM_DIR}" ]; then
    # Create dvm dir, and set sticky bit
    mkdir -p ${DVM_DIR}
    chown "${USERNAME}:dvm" ${DVM_DIR}
    chmod g+rws ${DVM_DIR}
    su ${USERNAME} -c "${dvm_install_snippet}" 2>&1
else
    echo "dvm already installed."
fi

echo "Done!"
