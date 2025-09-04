#!/bin/bash
set -o errexit -o pipefail

[ -z "$1" ] && echo "Please provide the version" && exit 1;
VERSION=$1


send_chat_message(){
    MESSAGE=$1
    if [ -z "$GOOGLE_CHAT_RELEASE_CHANEL" ] ; then
        echo "Environement variable GOOGLE_CHAT_RELEASE_CHANEL is not definied ... skipping message publishing"
    else
        DATA='{"text":"'${MESSAGE}'"}'
        echo $DATA
        curl -X POST --header "Content-Type:application/json" $GOOGLE_CHAT_RELEASE_CHANEL -d "${DATA}"
    fi
}



# Generate the md documentation
./mkDocs.sh

# Tag the version
git add docs/docs/dc_services/docker_compose_services_*.md
git commit -m "Update docker compose services documentation"
git tag -a ${VERSION} -m "ARLAS Exploration stack ${VERSION}"
git push --tags

send_chat_message "Release of ARLAS Exploration Stack, version ${VERSION}"
