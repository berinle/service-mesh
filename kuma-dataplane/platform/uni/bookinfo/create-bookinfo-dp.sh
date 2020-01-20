#!/bin/bash

## reference: https://github.com/Kong/kuma/issues/367

INPUT_DATAPLANE_DIR="dataplane"

function create_dataplane {
  DATAPLANE_NAME="$1"
  DATAPLANE_IP="$2"
  DATAPLANE_RESOURCE="$3"

  echo "Creating dataplane '${DATAPLANE_NAME}' ..."

  echo "${DATAPLANE_RESOURCE}" | kumactl apply --var DATA_PLANE_IP="${DATAPLANE_IP}" -f "${INPUT_DATAPLANE_DIR}/${DATAPLANE_RESOURCE}"
}

#
# Create dataplanes and generate tokens
#

# create_dataplane dp-productpage-1 192.168.16.5 dp-productpage-v1.yaml
# create_dataplane dp-details-1     192.168.16.4 dp-details-v1.yaml
# create_dataplane dp-reviews-1     192.168.16.3 dp-reviews-v1.yaml
# create_dataplane dp-rating-1      192.168.16.2 dp-rating-v1.yaml
# create_dataplane dp-rating-2      192.168.16.6 dp-rating-v2.yaml
# create_dataplane dp-mongo-1      192.168.16.7 dp-mongo.yaml
create_dataplane dp-reviews-3      192.168.16.8 dp-reviews-v3.yaml

# for f in "${DATA_PLANE_FILES[@]}"; do
#   kumactl apply -f $f --var DATA_PLANE_IP=$DATA_PLANE_IP
#   echo "registered $f"
# done

echo 'Done.'