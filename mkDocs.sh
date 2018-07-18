#!/bin/sh -e

# Create target directory
rm -fr target
mkdir -p target/generated-docs

# Move all documentation to folder `generated-docs`
if [ -d docs ] ; then
    cp -r docs/* target/generated-docs
fi
