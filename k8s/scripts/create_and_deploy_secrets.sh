#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

# =============================================================================
# Create or update Kubernetes Secrets for selected arlas-stack components.
#
# Usage:
#   ./create-secrets.sh arlas keycloak
#   ./create-secrets.sh rabbitmq
#   ./create-secrets.sh arlas keycloak rabbitmq elasticsearch
#
# Supported components:
#   arlas          -> arlas-stack-secret
#   keycloak       -> keycloak-bootstrap-admin, keycloak-db
#   rabbitmq       -> arlas-rabbitmq-default-user
#   elasticsearch  -> ${ES_CLUSTER_NAME}-user
#
# Configuration is loaded from ENV_FILE, then completed by variables already
# defined in the current environment. The .env file takes precedence.
# =============================================================================

ENV_FILE="${ENV_FILE:-./conf/secret.env}"

# Namespace where the Secrets will be created.
# It must match the namespace used by the arlas-stack Helm release.
NAMESPACE=

# ARLAS stack Secret.
ARLAS_APP_KEYCLOAK_SECRET=
ARLAS_APP_SEAWEEDFS_LOGIN=
ARLAS_APP_SEAWEEDFS_PASSWORD=
ARLAS_APP_CELERY_BROKER_URL=
ARLAS_APP_CELERY_RESULT_BACKEND=
ARLAS_APP_REDIS_PASSWORD=
ARLAS_APP_SMTP_PASSWORD=
ARLAS_APP_ELASTIC_LOGIN=
ARLAS_APP_ELASTIC_PASSWORD=

# Keycloak and PostgreSQL credentials.
ARLAS_APP_KEYCLOAK_LOGIN=
ARLAS_APP_KEYCLOAK_PASSWORD=
ARLAS_APP_POSTGRES_LOGIN=
ARLAS_APP_POSTGRES_PASSWORD=

# RabbitMQ credentials.
ARLAS_APP_RABBITMQ_LOGIN=
ARLAS_APP_RABBITMQ_PASSWORD=

# Elasticsearch cluster name.
# Used to build the Elasticsearch user Secret name: ${ES_CLUSTER_NAME}-user.
ES_CLUSTER_NAME="${ES_CLUSTER_NAME:-arlas-elasticsearch}"

readonly SUPPORTED_COMPONENTS=(arlas aproc keycloak rabbitmq elasticsearch)

# Variables required for each component.
readonly ARLAS_REQUIRED_VARS=(
  ARLAS_APP_KEYCLOAK_SECRET
  ARLAS_APP_ELASTIC_LOGIN
  ARLAS_APP_ELASTIC_PASSWORD
  ARLAS_APP_SEAWEEDFS_LOGIN
  ARLAS_APP_SEAWEEDFS_PASSWORD
  ARLAS_APP_CELERY_BROKER_URL
  ARLAS_APP_CELERY_RESULT_BACKEND
  ARLAS_APP_REDIS_PASSWORD
  ARLAS_APP_SMTP_PASSWORD
)

readonly KEYCLOAK_REQUIRED_VARS=(
  ARLAS_APP_KEYCLOAK_LOGIN
  ARLAS_APP_KEYCLOAK_PASSWORD
  ARLAS_APP_POSTGRES_LOGIN
  ARLAS_APP_POSTGRES_PASSWORD
)

readonly RABBITMQ_REQUIRED_VARS=(
  ARLAS_APP_RABBITMQ_LOGIN
  ARLAS_APP_RABBITMQ_PASSWORD
)

readonly ELASTICSEARCH_REQUIRED_VARS=(
  ARLAS_APP_ELASTIC_LOGIN
  ARLAS_APP_ELASTIC_PASSWORD
)

# -----------------------------------------------------------------------------
# Helpers
# -----------------------------------------------------------------------------

log_info() {
  printf 'INFO: %s\n' "$*" >&2
}

log_warn() {
  printf 'WARNING: %s\n' "$*" >&2
}

log_error() {
  printf 'ERROR: %s\n' "$*" >&2
}

die() {
  log_error "$*"
  exit 1
}

usage() {
  cat >&2 <<EOF
Usage: $0 <component> [<component>...]

Components:
  aproc          Create/update aproc-encryption-keys
  arlas          Create/update arlas-stack-secret
  keycloak       Create/update keycloak-bootstrap-admin and keycloak-db
  rabbitmq       Create/update arlas-rabbitmq-default-user
  elasticsearch  Create/update \${ES_CLUSTER_NAME}-user

Examples:
  $0 arlas keycloak
  $0 rabbitmq
  $0 arlas aproc keycloak rabbitmq elasticsearch

Environment:
  ENV_FILE       Path to the .env file (default: ./conf/secret.env)
EOF
  exit 1
}

is_set() {
  [[ -n "${!1:-}" ]]
}

load_env_file() {
  local file="$1"

  [[ -f "$file" ]] || return 1
  [[ -r "$file" ]] || die "$file exists but is not readable"

  set -o allexport
  # shellcheck disable=SC1090
  . "$file"
  set +o allexport
}

validate_required_vars() {
  local component="$1"
  shift

  local missing=()
  local var

  for var in "$@"; do
    if ! is_set "$var"; then
      missing+=("$var")
    fi
  done

  if (( ${#missing[@]} > 0 )); then
    log_error "Missing or empty variables required for component '$component':"
    printf '  - %s\n' "${missing[@]}" >&2
    log_error "Define them in $ENV_FILE or in the current environment."
    exit 1
  fi
}

apply_literal_secret() {
  local namespace="$1"
  local secret_name="$2"
  shift 2

  local args=(
    create secret generic "$secret_name"
    --dry-run=client
    -o yaml
  )

  local pair
  for pair in "$@"; do
    args+=(--from-literal="$pair")
  done

  kubectl -n "$namespace" "${args[@]}" | kubectl apply -f -
}

# -----------------------------------------------------------------------------
# Parse arguments
# -----------------------------------------------------------------------------

(( $# > 0 )) || usage

declare -A selected_components=()

for component in "$@"; do
  case "$component" in
    arlas|keycloak|rabbitmq|elasticsearch)
      selected_components["$component"]=1
      ;;
    -h|--help)
      usage
      ;;
    *)
      log_error "Unknown component: $component"
      usage
      ;;
  esac
done

# -----------------------------------------------------------------------------
# Load and validate common configuration
# -----------------------------------------------------------------------------

if [[ -f "$ENV_FILE" ]]; then
  log_info "Loading configuration from $ENV_FILE"
  load_env_file "$ENV_FILE"
else
  log_warn "$ENV_FILE not found; using variables from the current environment only"
fi

validate_required_vars namespace NAMESPACE

# -----------------------------------------------------------------------------
# Create Secrets for the selected components
# -----------------------------------------------------------------------------
kubectl create namespace "$NAMESPACE"  --dry-run=client -o yaml | kubectl apply -f -
if [[ -n "${selected_components[arlas]:-}" ]]; then
  log_info "Creating or updating Secrets for component: arlas"

  validate_required_vars arlas "${ARLAS_REQUIRED_VARS[@]}"

  apply_literal_secret "$NAMESPACE" arlas-stack-secret \
    "ARLAS_APP_KEYCLOAK_SECRET=$ARLAS_APP_KEYCLOAK_SECRET" \
    "ARLAS_APP_ELASTIC_LOGIN=$ARLAS_APP_ELASTIC_LOGIN" \
    "ARLAS_APP_ELASTIC_PASSWORD=$ARLAS_APP_ELASTIC_PASSWORD" \
    "ARLAS_APP_SEAWEEDFS_LOGIN=$ARLAS_APP_SEAWEEDFS_LOGIN" \
    "ARLAS_APP_SEAWEEDFS_PASSWORD=$ARLAS_APP_SEAWEEDFS_PASSWORD" \
    "ARLAS_APP_CELERY_BROKER_URL=$ARLAS_APP_CELERY_BROKER_URL" \
    "ARLAS_APP_CELERY_RESULT_BACKEND=$ARLAS_APP_CELERY_RESULT_BACKEND" \
    "ARLAS_APP_REDIS_PASSWORD=$ARLAS_APP_REDIS_PASSWORD" \
    "ARLAS_APP_SMTP_PASSWORD=$ARLAS_APP_SMTP_PASSWORD"
fi

if [[ -n "${selected_components[keycloak]:-}" ]]; then
  log_info "Creating or updating Secrets for component: keycloak"

  validate_required_vars keycloak "${KEYCLOAK_REQUIRED_VARS[@]}"

  apply_literal_secret "$NAMESPACE" keycloak-bootstrap-admin \
    "username=$ARLAS_APP_KEYCLOAK_LOGIN" \
    "password=$ARLAS_APP_KEYCLOAK_PASSWORD"

  apply_literal_secret "$NAMESPACE" keycloak-db \
    "username=$ARLAS_APP_POSTGRES_LOGIN" \
    "password=$ARLAS_APP_POSTGRES_PASSWORD"
fi

if [[ -n "${selected_components[rabbitmq]:-}" ]]; then
  log_info "Creating or updating Secrets for component: rabbitmq"

  validate_required_vars rabbitmq "${RABBITMQ_REQUIRED_VARS[@]}"

  for var in ARLAS_APP_RABBITMQ_LOGIN ARLAS_APP_RABBITMQ_PASSWORD; do
    if [[ "${!var}" == *$'\n'* || "${!var}" == *$'\r'* ]]; then
      die "$var must not contain a newline or carriage return"
    fi
  done

  RABBITMQ_DEFAULT_USER_CONF=$(printf \
    'default_user = %s\ndefault_pass = %s\n' \
    "$ARLAS_APP_RABBITMQ_LOGIN" \
    "$ARLAS_APP_RABBITMQ_PASSWORD")

  apply_literal_secret "$NAMESPACE" arlas-rabbitmq-default-user \
    "username=$ARLAS_APP_RABBITMQ_LOGIN" \
    "password=$ARLAS_APP_RABBITMQ_PASSWORD" \
    "default_user.conf=$RABBITMQ_DEFAULT_USER_CONF"

  kubectl -n "$NAMESPACE" label secret arlas-rabbitmq-default-user \
    app.kubernetes.io/name=arlas-rabbitmq \
    --overwrite
fi

if [[ -n "${selected_components[elasticsearch]:-}" ]]; then
  log_info "Creating or updating Secrets for component: elasticsearch"

  validate_required_vars elasticsearch "${ELASTICSEARCH_REQUIRED_VARS[@]}"

  kubectl -n "$NAMESPACE" create secret generic "${ES_CLUSTER_NAME}-user" \
    --type=kubernetes.io/basic-auth \
    --from-literal=username="$ARLAS_APP_ELASTIC_LOGIN" \
    --from-literal=password="$ARLAS_APP_ELASTIC_PASSWORD" \
    --from-literal=roles=superuser \
    --dry-run=client \
    -o yaml |
  kubectl apply -f -
fi

if [[ -n "${selected_components[aproc]:-}" ]]; then
  log_info "Creating or updating Secrets for component: aproc"

  KEY=$(docker run --rm python:3.13-slim \
    sh -c 'pip install --no-cache-dir cryptography >/dev/null && \
          python -c "from cryptography.fernet import Fernet; print(Fernet.generate_key().decode())"')

  kubectl -n "$NAMESPACE" create secret generic aproc-encryption-keys \
    --from-literal=APROC_TASK_ENCRYPTION_KEYS="$KEY" \
    --dry-run=client -o yaml | kubectl apply -f -
fi

log_info "Successfully created or updated Secrets for: $* in namespace '$NAMESPACE'"