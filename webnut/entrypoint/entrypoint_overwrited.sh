#!/bin/bash -e

source /scripts/file_env.sh

file_env "UPS_USER"
file_env "UPS_PASSWORD"

source /docker-entrypoint.sh
