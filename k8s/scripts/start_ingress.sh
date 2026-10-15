#!/bin/bash
set -o errexit -o pipefail


GATEWAY_PARAMS="\
global.gateway.enabled=false,\
deployment.arlas.uis.gateway.enabled=false,\
deployment.arlas.services.gateway.enabled=false,\
deployment.aias.uis.gateway.enabled=false,\
deployment.aias.services.airs.gateway.enabled=false,\
deployment.aias.services.aproc.gateway.enabled=false,\
deployment.aias.services.fam.gateway.enabled=false,\
deployment.aias.services.titiler.gateway.enabled=false,\
deployment.seaweedfs.gateway.enabled=false,\
deployment.elasticsearch.app.gateway.enabled=false,\
deployment.elasticsearch.logs.gateway.enabled=false,\
deployment.kibana.app.gateway.enabled=false,\
deployment.kibana.logs.gateway.enabled=false,\
deployment.keycloak.gateway.enabled=false,\
elastic.instances.app.elasticsearch.gateway.enabled=false,\
elastic.instances.logs.elasticsearch.gateway.enabled=false,\
elastic.instances.app.kibana.gateway.enabled=false,\
elastic.instances.logs.kibana.gateway.enabled=false,\
global.gateway.hostPort.enabled=false"

INGRESS_PARAMS="\
deployment.arlas.uis.ingress.enabled=true,\
deployment.arlas.services.ingress.enabled=true,\
deployment.aias.services.airs.ingress.enabled=true,\
deployment.aias.uis.ingress.enabled=true,\
deployment.aias.services.aproc.ingress.enabled=true,\
deployment.aias.services.fam.ingress.enabled=true,\
deployment.aias.services.titiler.ingress.enabled=true,\
deployment.seaweedfs.ingress.enabled=true,\
deployment.elasticsearch.app.ingress.enabled=true,\
deployment.elasticsearch.logs.ingress.enabled=true,\
deployment.kibana.app.ingress.enabled=true,\
deployment.kibana.logs.ingress.enabled=true,\
deployment.keycloak.ingress.enabled=true,\
elastic.instances.app.elasticsearch.ingress.enabled=true,\
elastic.instances.logs.elasticsearch.ingress.enabled=true,\
elastic.instances.app.kibana.ingress.enabled=true,\
elastic.instances.logs.kibana.ingress.enabled=true,\
keycloak.ingress.enabled=true"

./k8s/scripts/start.sh  --set "$INGRESS_PARAMS" --set "$GATEWAY_PARAMS"