#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "dvm" bash -c "/usr/local/share/dvm/bin/dvm lr"

# Report result
reportResults
