#!/bin/bash

COMPOSE_SERVICES=$(docker ps -a --format "{{.Names}}")

echo "CHECKING SERVICES STATUS PRINTING LOGS FOR UNHEALTHY SERVICES ..."
for SERVICE in $COMPOSE_SERVICES
do
    SERVICE_STATUS=$(docker inspect --format='{{if .State.Health}}{{.State.Health.Status}}{{else}}no healthcheck{{end}}' "$SERVICE" 2>/dev/null || echo "failed to retrieve status")
    if [ "$SERVICE_STATUS" != "healthy" ] && [ "$SERVICE_STATUS" != "no healthcheck" ]
    then
        echo "ERROR: $SERVICE status is not healthy: $SERVICE_STATUS"
        echo "LOGS FOR $SERVICE"
        docker logs $SERVICE --tail 1000
    fi
done
