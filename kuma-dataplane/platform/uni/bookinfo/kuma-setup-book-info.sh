#!/bin/sh

set -e

if [ -z "${INPUT_DATAPLANE_DIR}" ]; then
  echo "Error: environment variable INPUT_DATAPLANE_DIR is not set"
  exit 1
fi

if [ -z "${OUTPUT_TOKEN_DIR}" ]; then
  echo "Error: environment variable OUTPUT_TOKEN_DIR is not set"
  exit 1
fi

#
# Utility functions
#

function create_dataplane {
  DATAPLANE_NAME="$1"
  DATAPLANE_IP="$2"
  DATAPLANE_RESOURCE="$3"

  echo "Creating dataplane '${DATAPLANE_NAME}' ..."

  echo "${DATAPLANE_RESOURCE}" | kumactl apply --var DATA_PLANE_IP="${DATAPLANE_IP}" -f "${INPUT_DATAPLANE_DIR}/${DATAPLANE_RESOURCE}"

  echo "Generating dataplane token for '${DATAPLANE_NAME}' ..."

  mkdir -p "${OUTPUT_TOKEN_DIR}"
  kumactl generate dataplane-token --dataplane "${DATAPLANE_NAME}" --mesh default >"${OUTPUT_TOKEN_DIR}/${DATAPLANE_NAME}"
}

#
# Create dataplanes and generate tokens
#

create_dataplane dp-productpage-1 192.168.16.5 dp-productpage-v1.yaml
create_dataplane dp-details-1     192.168.16.4 dp-details-v1.yaml
create_dataplane dp-reviews-1     192.168.16.3 dp-reviews-v1.yaml
create_dataplane dp-rating-1      192.168.16.2 dp-rating-v1.yaml
