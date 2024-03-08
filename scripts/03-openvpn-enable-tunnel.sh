#!/usr/bin/env bash

set -e

SERVER_IP=${1-""}

if [[ $# -ne 1 ]]; then
  echo "usage:"
  echo "$0 SERVER_IP"
  exit -1
fi


SECRET_KEYFILE="./secrets/static.key"
OPENVPN_KEYFILE="/etc/openvpn/static.key"
OPENVPN_CLIENT_CONFIG="/etc/openvpn/client.conf"

cp ${SECRET_KEYFILE} ${OPENVPN_KEYFILE}

# openvpn \
#   --remote ${SERVER_IP} \
#   --dev tun1 \
#   --ifconfig 10.9.8.2 10.9.8.1 \
#   --secret ${SECRET_KEYFILE} \
#   --cipher AES-256-CBC

cat > ${OPENVPN_CLIENT_CONFIG} <<EOF
dev tun1
proto udp
remote ${SERVER_IP}
ifconfig 10.9.8.2 10.9.8.1
secret ${OPENVPN_KEYFILE}
cipher AES-256-CBC
redirect-gateway def1

EOF

service openvpn@client start