#!/bin/bash
set -o errexit -o pipefail

GATEWAY_PARAMS="\
global.gateway.enabled=true,\
deployment.arlas.uis.gateway.enabled=true,\
deployment.arlas.services.gateway.enabled=true,\
deployment.aias.uis.gateway.enabled=true,\
deployment.aias.services.airs.gateway.enabled=true,\
deployment.aias.services.aproc.gateway.enabled=true,\
deployment.aias.services.fam.gateway.enabled=true,\
deployment.aias.services.titiler.gateway.enabled=true,\
deployment.seaweedfs.gateway.enabled=true,\
deployment.elasticsearch.app.gateway.enabled=true,\
deployment.elasticsearch.logs.gateway.enabled=true,\
deployment.kibana.app.gateway.enabled=true,\
deployment.kibana.logs.gateway.enabled=true,\
deployment.keycloak.gateway.enabled=true,\
elastic.instances.app.elasticsearch.gateway.enabled=true,\
elastic.instances.logs.elasticsearch.gateway.enabled=true,\
elastic.instances.app.kibana.gateway.enabled=true,\
elastic.instances.logs.kibana.gateway.enabled=true,\
global.gateway.hostPort.enabled=true"

INGRESS_PARAMS="\
deployment.arlas.uis.ingress.enabled=false,\
deployment.arlas.services.ingress.enabled=false,\
deployment.aias.uis.ingress.enabled=false,\
deployment.aias.services.airs.ingress.enabled=false,\
deployment.aias.services.aproc.ingress.enabled=false,\
deployment.aias.services.fam.ingress.enabled=false,\
deployment.aias.services.titiler.ingress.enabled=false,\
deployment.seaweedfs.ingress.enabled=false,\
deployment.elasticsearch.app.ingress.enabled=false,\
deployment.elasticsearch.logs.ingress.enabled=false,\
deployment.kibana.app.ingress.enabled=false,\
deployment.kibana.logs.ingress.enabled=false,\
deployment.keycloak.ingress.enabled=false,\
elastic.instances.app.elasticsearch.ingress.enabled=false,\
elastic.instances.logs.elasticsearch.ingress.enabled=false,\
elastic.instances.app.kibana.ingress.enabled=false,\
elastic.instances.logs.kibana.ingress.enabled=false,\
keycloak.ingress.enabled=false"

./k8s/scripts/start.sh  --set "$INGRESS_PARAMS" --set "$GATEWAY_PARAMS"