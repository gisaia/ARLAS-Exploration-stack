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

    echo "Installing Keycloak with version: $KC_KUSTOMIZE_REF"

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