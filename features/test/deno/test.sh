#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "tmp" ls /usr/local/share -la
check "dvm" /usr/local/share/dvm/bin/dvm ls
check "deno" deno -V

# Report result
reportResults
