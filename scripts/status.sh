
COMPOSE_SERVICES=$(docker ps -a --format "{{.Names}}")

for SERVICE in $COMPOSE_SERVICES
do
    SERVICE_STATUS=$(docker inspect --format='{{if .State.Health}}{{.State.Health.Status}}{{else}}no healthcheck{{end}}' "$SERVICE" 2>/dev/null || echo "failed to retrieve status")
    echo "$SERVICE status: $SERVICE_STATUS"
done
