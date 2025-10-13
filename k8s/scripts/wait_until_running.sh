set -o errexit -o pipefail
namespace="arlas"
if [ -z "$1" ]
then
    echo "Using default namespace $namespace"
else
    namespace=$1
    echo "Using provided namespace $namespace"
fi

not_running_pods_fct(){
    # for now, arlas-permissions-server, arlas-persistence-server and arlas-server can not be running since host names are not set.
    echo $( kubectl get pods --namespace "$namespace" --no-headers  | grep -v "create-and-public-minio"  | grep -v "arlas-agate"   | grep -v "arlas-permissions-server"  | grep -v "arlas-persistence-server"  | grep -v "arlas-server" | awk '$3 != "Running" {print $1}' )
}

# Define the maximum number of loops
max_loops=60

# Define the namespace you want to check

# Loop to check the status of the pods
for (( loop=1; loop<=$max_loops; loop++ )); do
    echo "Checking pod status (Loop $loop/$max_loops)..."

    # Get the list of pods not in Running phase
    not_running_pods=$( not_running_pods_fct )

    # Check if there are any pods not running
    if [[ -z "$not_running_pods" ]]; then
        break
    else
        echo "The following pods are not running: $not_running_pods"
        # Wait for a few seconds before checking again
        sleep 10
    fi

done

not_running_pods=$( not_running_pods_fct )

if [[ -z "$not_running_pods" ]]; then
    echo "All important pods are running."
else
    kubectl describe pod --namespace "$namespace" $not_running_pods
    
    echo "Error: Not all pods are running after $max_loops checks: $not_running_pods"
    for pod in $not_running_pods; do
        kubectl logs --namespace arlas $pod
    done
    exit 1
fi
