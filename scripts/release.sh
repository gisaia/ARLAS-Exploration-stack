#!/bin/bash
set -o errexit -o pipefail

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

yq eval '.appVersion = "'${AIAS_VERSION}'"' -i k8s/charts/aias-services/Chart.yaml
yq eval '.appVersion = "'${ARLAS_VERSION}'"' -i k8s/charts/arlas-services/Chart.yaml
yq eval '.appVersion = "'${VERSION}'"' -i k8s/charts/arlas-stack/Chart.yaml
yq eval '.appVersion = "'${WUI_VERSION}'"' -i k8s/charts/arlas-uis/Chart.yaml
yq eval '.appVersion = "'${TITILER_VERSION}'"' -i k8s/charts/titiler/Chart.yaml

yq eval '( .dependencies[] | select(.name == "aias-services").version ) = "'${VERSION}'"' -i k8s/charts/arlas-stack/Chart.yaml
yq eval '( .dependencies[] | select(.name == "arlas-services").version ) = "'${VERSION}'"' -i k8s/charts/arlas-stack/Chart.yaml
yq eval '( .dependencies[] | select(.name == "arlas-uis").version ) = "'${VERSION}'"' -i k8s/charts/arlas-stack/Chart.yaml
yq eval '( .dependencies[] | select(.name == "titiler").version ) = "'${VERSION}'"' -i k8s/charts/arlas-stack/Chart.yaml

git add k8s/charts/aias-services/Chart.yaml
git add k8s/charts/arlas-services/Chart.yaml
git add k8s/charts/arlas-uis/Chart.yaml
git add k8s/charts/titiler/Chart.yaml
git add k8s/charts/arlas-stack/Chart.yaml
git commit -m "Update helm charts for version ${VERSION}"

sed -i 's|file://\.\./|https://gisaia.github.io/ARLAS-Exploration-stack/|g' k8s/charts/arlas-stack/Chart.yaml
helm package k8s/charts/aias-services/ --destination charts/
helm package k8s/charts/arlas-services/ --destination charts/
helm package k8s/charts/arlas-uis/ --destination charts/
helm package k8s/charts/titiler/ --destination charts/
helm package k8s/charts/arlas-stack/ --destination charts/
git checkout k8s/charts/arlas-stack/Chart.yaml

git checkout gh-pages
mv charts/*tgz .
helm repo index . --url https://gisaia.github.io/ARLAS-exploration-stack
git add *.tgz index.yaml
git commit -m "Update helm charts for version ${VERSION}"
git push origin gh-pages
git checkout -

exit 0

# Generate the md documentation
./mkDocs.sh

echo "ARLAS Exploration Stack version ${VERSION}:" > docs/docs/version.md
echo " " >> docs/docs/version.md
echo " - ARLAS Server version : ${ARLAS_VERSION}" >> docs/docs/version.md
echo " - ARLAS WUI version : ${WUI_VERSION}" >> docs/docs/version.md
echo " - AIAS version : ${AIAS_VERSION}" >> docs/docs/version.md
echo " - TiTiler version : ${TITILER_VERSION}" >> docs/docs/version.md

# Tag the version

git add docs/docs/
git commit -m "Update docker compose services documentation"
git tag -a ${VERSION} -m "ARLAS Exploration stack ${VERSION}"
git push origin --tags
git push origin

send_chat_message "Release of ARLAS Exploration Stack, version ${VERSION}"
