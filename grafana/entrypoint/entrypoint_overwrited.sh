#!/bin/bash -e

source /scripts/file_env.sh

file_env "GF_SECURITY_ADMIN_USER"
file_env "GF_SECURITY_ADMIN_PASSWORD"

source /run.sh
