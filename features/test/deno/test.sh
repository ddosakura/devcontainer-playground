#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "tmp1" ls /usr/local/share -la
check "tmp2" ls $HOME -la
check "tmp3" ls /root -la
check "tmp4" ls /home -la
check "dvm" /usr/local/share/dvm/bin/dvm ls
check "deno" deno -V

# Report result
reportResults
