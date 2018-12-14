#!/bin/bash 

set -e -o pipefail

# Create target directory if it does not exist
mkdir -p target/generated-docs

# Move all documentation to folder `generated-docs`
if [[ -d docs ]]; then
    cp -r docs/* target/generated-docs/
fi
