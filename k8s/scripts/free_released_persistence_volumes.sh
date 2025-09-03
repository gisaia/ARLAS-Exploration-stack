#!/bin/bash
set -o errexit -o pipefail

RELEASED_PVS=$(kubectl get pv  -n arlas  | grep Released  | awk '{print $1}')

if [ -z "$RELEASED_PVS" ]; then
    echo "No PVs in 'Released' state found."
    exit 0
fi

echo "Found the following PVs in 'Released' state:"
echo "$RELEASED_PVS"

for PV in $RELEASED_PVS; do
    echo "Processing PV: $PV"

    # Remove claimRef
    kubectl patch pv -n arlas $PV --type=json -p '[{"op": "remove", "path": "/spec/claimRef"}]'
done

echo "All 'Released' PVs have been made available."
