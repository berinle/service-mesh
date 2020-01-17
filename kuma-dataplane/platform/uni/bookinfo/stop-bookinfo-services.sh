#!/bin/bash

# stop all services
# docker stop review-v1 details-v1 ratings-v1 productpage-v1
docker-compose $(find docker* | sed -e 's/^/-f /') stop
