#!/bin/bash

DATA_PLANE_IP=127.0.0.1

### run ratings service
docker run -d --name ratings-v1 \
    -e ENABLE_RATINGS=true \
    -p 39080:9080 --rm berinle/examples-bookinfo-ratings-v1:latest

# mongo
# docker run -d --name mongo \
#     -p 27017:27017 \
#     --rm berinle/examples-bookinfo-mongodb:latest

# # rating v2
# docker run -d --name ratings-v2 \
#     -e ENABLE_RATINGS=true \
#     -e MONGO_DB_URL=mongodb://0.tcp.ngrok.io:17163/test \
#     -p 39090:9080 --rm berinle/examples-bookinfo-ratings-v2:latest


### run review service
docker run -d --name review-v1 \
    -e RATINGS_HOSTNAME=$DATA_PLANE_IP \
    -e RATINGS_PORT=39082 \
    -e ENABLE_RATINGS=true \
    -p 19080:9080 --rm berinle/examples-bookinfo-reviews-v1:latest

### run details service
docker run -d --name details-v1 -p 29080:9080 --rm berinle/examples-bookinfo-details-v1:latest

### run product page app
docker run -d --name productpage-v1 -p 49080:9080 \
    -e DETAILS_HOSTNAME=$DATA_PLANE_IP \
    -e RATINGS_HOSTNAME=$DATA_PLANE_IP \
    -e REVIEWS_HOSTNAME=$DATA_PLANE_IP \
    -e DETAILS_PORT=29082 \
    -e RATINGS_PORT=39082 \
    -e REVIEWS_PORT=19082 \
    --rm berinle/examples-bookinfo-productpage-v1:latest