#!/bin/bash
set -o errexit -o pipefail
[ -z "$1" ] && echo "Please provide the max zoom level (>1)" && exit 1;
MAX_ZOOM=$1

check_command(){
    COMMAND_NAME=$1
    if ! command -v $COMMAND_NAME >/dev/null 2>&1; then
        echo "Error: '$COMMAND_NAME' is not installed. Please install it first."
        exit 1
    fi
}

check_command "pmtiles"

pmtiles extract https://build.protomaps.com/20231225.pmtiles conf/protomaps/world.pmtiles --minzoom=0 --maxzoom $MAX_ZOOM
