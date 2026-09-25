#!/bin/bash
set -o errexit -o pipefail

check_command(){
    COMMAND_NAME=$1
    if ! command -v "$COMMAND_NAME" >/dev/null 2>&1; then
        echo "Error: '$COMMAND_NAME' is not installed. Please install it first."
        exit 1
    fi
}

check_command "kubectl"
check_command "yq"

# List of components (ex: ./install_operators.sh keycloak@26.8.0 elasticsearch)
COMPONENTS=("$@")


# Function to get version for a component (returns latest if not specified)
# Usage: version=$(get_component_version "keycloak" "${COMPONENTS[@]}")
get_component_version() {
    local component="$1"
    shift
    for item in "$@"; do
        if [[ "$item" == "${component}@"* ]]; then
            echo "${item#${component}@}"
            return 0
        fi
    done
    echo "latest"
    return 0
}

# Function to check if component is in the list (with or without version)
# Usage: if has_component "keycloak" "${COMPONENTS[@]}"; then ...
has_component() {
    local component="$1"
    shift
    for item in "$@"; do
        if [[ "$item" == "$component" || "$item" == "${component}@"* ]]; then
            return 0
        fi
    done
    return 1
}

# Install keycloak
if has_component "keycloak" "${COMPONENTS[@]}"; then
    # Get version from arguments or use default
    KC_VERSION=$(get_component_version "keycloak" "${COMPONENTS[@]}")
    KC_KUSTOMIZE_REF="${KC_VERSION:-26.7.4}"

    echo "Installing Keycloak operator with version: $KC_KUSTOMIZE_REF"

    # Create keycloak namespace if does not exist
    if ! kubectl get namespace keycloak-operator &> /dev/null; then
        echo "Creating namespace: keycloak-operator"
        kubectl create namespace keycloak-operator
    else
        echo "Namespace keycloak-operator already exists, skipping creation"
    fi

    # Applying Keycloak operator resources
    echo "Applying Keycloak operator resources from ref $KC_KUSTOMIZE_REF..."
    kubectl apply -k "github.com/keycloak/keycloak-k8s-resources/kubernetes/cluster-wide?ref=$KC_KUSTOMIZE_REF"
fi

# Install elastic
ELASTIC_OPERATOR_CHART_VERSION="${ELASTIC_OPERATOR_CHART_VERSION:-3.5.0}"
ELASTIC_OPERATOR_NAMESPACE="elastic-system"
ELASTIC_HELM_REPO_URL="https://helm.elastic.co"

if has_component "elasticsearch" "${COMPONENTS[@]}"; then
    # Get version from arguments or use default
    ELASTIC_VERSION=$(get_component_version "elasticsearch" "${COMPONENTS[@]}")
    ELASTIC_OPERATOR_CHART_VERSION="${ELASTIC_VERSION:-3.5.0}"
    echo "Ensuring 'elastic' Helm repo is present and up to date..."
    helm repo add elastic "$ELASTIC_HELM_REPO_URL" --force-update
    helm repo update elastic

    echo "Installing/upgrading ECK operator (version ${ELASTIC_OPERATOR_CHART_VERSION}) in namespace ${ELASTIC_OPERATOR_NAMESPACE}..."
    helm upgrade --install elastic-operator elastic/eck-operator \
    -n "$ELASTIC_OPERATOR_NAMESPACE" \
    --create-namespace \
    --version "$ELASTIC_OPERATOR_CHART_VERSION" \
    --wait \
    --atomic
fi


# Install RabbitMQ
if has_component "rabbitmq" "${COMPONENTS[@]}"; then
    RABBITMQ_VERSION=$(get_component_version "rabbitmq" "${COMPONENTS[@]}")
    RABBITMQ_OPERATOR_REF="${RABBITMQ_VERSION:-2.23.0}"
    # Applying RabbitMQ operator resources
    CERT_MANAGER_VERSION="v1.16.0"
    echo "Applying RabbiMQ operator resources from ref $RABBITMQ_OPERATOR_REF..."
    kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/$CERT_MANAGER_VERSION/cert-manager.yaml
    kubectl wait --for=condition=Available deployment/cert-manager -n cert-manager --timeout=120s
    kubectl wait --for=condition=Available deployment/cert-manager-webhook -n cert-manager --timeout=120s
    kubectl wait --for=condition=Available deployment/cert-manager-cainjector -n cert-manager --timeout=120s
    kubectl apply -f https://github.com/rabbitmq/cluster-operator/releases/download/v$RABBITMQ_OPERATOR_REF/cluster-operator.yml
    echo "Waiting for RabbitMQ cluster operator to be ready..."
    kubectl wait --for=condition=Ready pod -l app.kubernetes.io/name=rabbitmq-cluster-operator -n rabbitmq-system --timeout=120s
fi