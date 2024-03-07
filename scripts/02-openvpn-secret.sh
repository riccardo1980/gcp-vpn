#!/usr/bin/env bash

set -e

SERVER_IP=${1-""}

if [[ $# -ne 1 ]]; then
  echo "usage:"
  echo "$0 SERVER_IP"
  exit -1
fi


KEYFILE="static.key"

# KEYFILE is currently generated on server, so we download it
scp -o StrictHostKeyChecking=no \
    -i secrets/terraform.pem \
    terraform@${SERVER_IP}:~/${KEYFILE} \secrets/
