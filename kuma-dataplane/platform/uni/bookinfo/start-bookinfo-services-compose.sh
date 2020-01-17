#!/bin/sh
set -e

docker-compose $(find docker* | sed -e 's/^/-f /') up -d