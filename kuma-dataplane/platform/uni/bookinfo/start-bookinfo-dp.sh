#!/bin/bash
CP_HOSTNAME={KUMA_CONTROL_PLANE_HOSTNAME:-localhost}
TOKEN_PREFIX_PATH={TOKEN_PREFIX_PATH:-/tmp/secrets}

kuma-dp run \
  --name=dp-rating-1 \
  --mesh=default \
  --cp-address=http://${CP_HOSTNAME}:5681 \
  --dataplane-token-file=$TOKEN_PREFIX_PATH/dp-rating-1 \
  > /tmp/dp-rating-1.log &

# kuma-dp run \
#   --name=dp-rating-2 \
#   --mesh=default \
#   --cp-address=http://${CP_HOSTNAME}:5681 \
#   --dataplane-token-file=$TOKEN_PREFIX_PATH/dp-rating-2 \
#   > /tmp/dp-rating-2.log

# kuma-dp run \
#   --name=dp-mongo-1 \
#   --mesh=default \
#   --cp-address=http://${CP_HOSTNAME}:5681 \
#   --dataplane-token-file=$TOKEN_PREFIX_PATH/dp-mongo-1 \
#   > /tmp/dp-mongo-1.log &

kuma-dp run \
  --name=dp-reviews-1 \
  --mesh=default \
  --cp-address=http://${CP_HOSTNAME}:5681 \
  --dataplane-token-file=$TOKEN_PREFIX_PATH/dp-reviews-1 \
  > /tmp/dp-reviews-1.log &

kuma-dp run \
  --name=dp-details-1 \
  --mesh=default \
  --cp-address=http://${CP_HOSTNAME}:5681 \
  --dataplane-token-file=$TOKEN_PREFIX_PATH/dp-details-1 \
  > /tmp/dp-details-1.log &

kuma-dp run \
  --name=dp-productpage-1 \
  --mesh=default \
  --cp-address=http://${CP_HOSTNAME}:5681 \
  --dataplane-token-file=$TOKEN_PREFIX_PATH/dp-productpage-1 \
  > /tmp/dp-productpage-1.log &
