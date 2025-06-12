#!/usr/bin/env bash
set -o errexit -o pipefail
export HOST=`hostname`
echo $HOST
sed -i -e 's/localhost/'$HOST'/g' conf/stack.env
cat conf/stack.env
