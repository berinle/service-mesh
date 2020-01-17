#!/bin/bash

## reference: https://github.com/Kong/kuma/issues/367

# docker daemmon assigned ip
DATA_PLANE_IP=192.168.16.2 #ratings
# DATA_PLANE_IP=192.168.16.3 #reviews
# DATA_PLANE_IP=192.168.16.4 #details
# DATA_PLANE_IP=192.168.16.5 #productpage

# using host ip
# DATA_PLANE_IP=10.61.8.236

# DATA_PLANE_FILES=('dp-rating-v1.yaml' 'dp-reviews-v1.yaml' 'dp-details-v1.yaml' 'dp-productpage-v1.yaml')
DATA_PLANE_FILES=('dataplane/dp-rating-v1.yaml')
# DATA_PLANE_FILES=('dataplane/dp-reviews-v1.yaml')
# DATA_PLANE_FILES=('dataplane/dp-details-v1.yaml')
# DATA_PLANE_FILES=('dataplane/dp-productpage-v1.yaml')

for f in "${DATA_PLANE_FILES[@]}"; do
  kumactl apply -f $f --var DATA_PLANE_IP=$DATA_PLANE_IP
  echo "registered $f"
done

echo 'Done.'