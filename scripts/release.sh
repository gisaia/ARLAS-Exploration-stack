#!/bin/bash
set -o errexit -o pipefail

check_command(){
    COMMAND_NAME=$1
    if ! command -v $COMMAND_NAME >/dev/null 2>&1; then
        echo "Error: '$COMMAND_NAME' is not installed. Please install it first."
        exit 1
    fi
}

check_command "yq"
check_command "git"
check_command "helm"


[ -z "$1" ] && echo "Please provide the version" && exit 1;
VERSION=$1.0


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

# Extract current versions from the images: they define the appVersions in the charts
AIAS_VERSION=`yq '.services.airs.image' k8s/charts/aias-services/values.yaml | cut -d":" -f2`
ARLAS_VERSION=`yq '.services.server.image' k8s/charts/arlas-services/values.yaml | cut -d":" -f2`
WUI_VERSION=`yq '.uis.wui.image' k8s/charts/arlas-uis/values.yaml | cut -d":" -f2`
TITILER_VERSION=`yq '.image.tag' k8s/charts/titiler/values.yaml | cut -d":" -f2`

echo "Releasing ARLAS Exploration Stack version ${VERSION} with components versions :"
echo " - ARLAS Server version : ${ARLAS_VERSION}"
echo " - ARLAS WUI version : ${WUI_VERSION}"
echo " - AIAS version : ${AIAS_VERSION}"
echo " - TiTiler version : ${TITILER_VERSION}"

# Update the version in the chart files
yq eval '.version = "'${VERSION}'"' -i k8s/charts/aias-services/Chart.yaml
yq eval '.version = "'${VERSION}'"' -i k8s/charts/arlas-services/Chart.yaml
yq eval '.version = "'${VERSION}'"' -i k8s/charts/arlas-stack/Chart.yaml
yq eval '.version = "'${VERSION}'"' -i k8s/charts/arlas-uis/Chart.yaml
yq eval '.version = "'${VERSION}'"' -i k8s/charts/titiler/Chart.yaml

# Update the appVersion in the chart files
yq eval '.appVersion = "'${AIAS_VERSION}'"' -i k8s/charts/aias-services/Chart.yaml
yq eval '.appVersion = "'${ARLAS_VERSION}'"' -i k8s/charts/arlas-services/Chart.yaml
yq eval '.appVersion = "'${VERSION}'"' -i k8s/charts/arlas-stack/Chart.yaml
yq eval '.appVersion = "'${WUI_VERSION}'"' -i k8s/charts/arlas-uis/Chart.yaml
yq eval '.appVersion = "'${TITILER_VERSION}'"' -i k8s/charts/titiler/Chart.yaml

# Update dependencies versions in the arlas-stack chart: all the same current version
yq eval '( .dependencies[] | select(.name == "aias-services").version ) = "'${VERSION}'"' -i k8s/charts/arlas-stack/Chart.yaml
yq eval '( .dependencies[] | select(.name == "arlas-services").version ) = "'${VERSION}'"' -i k8s/charts/arlas-stack/Chart.yaml
yq eval '( .dependencies[] | select(.name == "arlas-uis").version ) = "'${VERSION}'"' -i k8s/charts/arlas-stack/Chart.yaml
yq eval '( .dependencies[] | select(.name == "titiler").version ) = "'${VERSION}'"' -i k8s/charts/arlas-stack/Chart.yaml

# Generate the md documentation
./mkDocs.sh

echo "ARLAS Exploration Stack version ${VERSION}:" > docs/docs/version.md
echo " " >> docs/docs/version.md
echo " - ARLAS Server version : ${ARLAS_VERSION}" >> docs/docs/version.md
echo " - ARLAS WUI version : ${WUI_VERSION}" >> docs/docs/version.md
echo " - AIAS version : ${AIAS_VERSION}" >> docs/docs/version.md
echo " - TiTiler version : ${TITILER_VERSION}" >> docs/docs/version.md
git add docs/docs/

git add k8s/charts/aias-services/Chart.yaml
git add k8s/charts/arlas-services/Chart.yaml
git add k8s/charts/arlas-uis/Chart.yaml
git add k8s/charts/titiler/Chart.yaml
git add k8s/charts/arlas-stack/Chart.yaml

git add k8s/charts/aias-services/README.md
git add k8s/charts/arlas-services/README.md
git add k8s/charts/arlas-stack/README.md
git add k8s/charts/arlas-uis/README.md
git add k8s/charts/titiler/README.md

# Tag the version

git commit -m "Update docker compose services documentation"
git tag -a ${VERSION} -m "ARLAS Exploration stack ${VERSION}"
git push origin --tags
git push origin

send_chat_message "Release of ARLAS Exploration Stack, version ${VERSION}"
