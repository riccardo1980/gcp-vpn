#!/usr/bin/env bash

set -e

if [[ $# -ne 0 ]]; then
  echo "usage:"
  echo "$0"
  exit -1
fi


SECRET_KEYFILE="./secrets/static.key"
OPENVPN_KEYFILE="/etc/openvpn/static.key"
OPENVPN_CLIENT_CONFIG="/etc/openvpn/client.conf"

echo "Stopping openvpn service..."
service openvpn@client stop

echo "Removing keyfile ${OPENVPN_KEYFILE}..."
rm ${OPENVPN_KEYFILE}

echo "Removing openvpn configuration ${OPENVPN_CLIENT_CONFIG}..."
rm ${OPENVPN_CLIENT_CONFIG}
