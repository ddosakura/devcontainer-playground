#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "check for node" node --version
check "check for deno" deno -V

# Report result
reportResults