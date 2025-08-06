set -o errexit -o pipefail
namespace="arlas"
if [ -z "$1" ]
then
    echo "Using default namespace $namespace"
else
    namespace=$1
    echo "Using provided namespace $namespace"
fi


# Define the maximum number of loops
max_loops=40

# Define the namespace you want to check

# Loop to check the status of the pods
for (( loop=1; loop<=$max_loops; loop++ )); do
    echo "Checking pod status (Loop $loop/$max_loops)..."

    # Get the list of pods not in Running phase
    not_running_pods=$(kubectl get pods --namespace "$namespace" --no-headers  | grep -v "create-and-public-minio" | awk '$3 != "Running" {print $1}')

    # Check if there are any pods not running
    if [[ -z "$not_running_pods" ]]; then
        echo "All pods are running."
        exit 0
    else
        echo "The following pods are not running: $not_running_pods"
    fi

    # Wait for a few seconds before checking again
    sleep 10
done

not_running_pods=$(kubectl get pods --namespace "$namespace" --no-headers  | grep -v "create-and-public-minio" | awk '$3 != "Running" {print $1}')
kubectl describe pod $not_running_pods

# If the loop completes without all pods running, exit with an error
echo "Error: Not all pods are running after $max_loops checks."
exit 1
