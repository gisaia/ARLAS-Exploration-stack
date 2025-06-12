#!/usr/bin/env bash
set -o errexit -o pipefail
export HOST=`hostname`
echo ARLAS_HOST=$HOST > conf/custom.env
cat conf/custom.env
