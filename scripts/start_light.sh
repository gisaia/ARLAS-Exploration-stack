#!/bin/bash
set -o errexit -o pipefail

export HOST=sylvains-macbook-air.local

docker compose -p arlas-light \
  --env-file env/apisix.env \
  --env-file env/arlas.env \
  --env-file env/arlas_auth.env \
  --env-file env/elastic.env \
  --env-file env/postgres.env \
  --env-file env/persistence-file.env \
  --env-file env/restart_strategy.env \
  --env-file env/stack.env \
  -f ref-dc-apisix.yaml \
  -f ref-dc-elastic-no-apm.yaml \
  -f ref-dc-arlas-builder.yaml \
  -f ref-dc-arlas-hub.yaml \
  -f ref-dc-arlas-hub.yaml \
  -f ref-dc-arlas-persistence-server.yaml \
  -f ref-dc-net.yaml \
  -f ref-dc-arlas-server.yaml	 \
  -f ref-dc-arlas-wui.yaml \
  -f ref-dc-protomaps.yaml \
  up -d --remove-orphans --wait
