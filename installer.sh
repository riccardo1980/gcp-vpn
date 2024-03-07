#!/usr/bin/env bash

set -e

apt-get -y remove --purge man-db
apt-get -y install openvpn

openvpn --genkey secret /etc/openvpn/static.key --cipher AES-256-CBC
cp /etc/openvpn/static.key /home/terraform/
chown terraform:terraform /home/terraform/static.key

cat > /etc/openvpn/server.conf <<EOF
dev tun0
ifconfig 10.9.8.1 10.9.8.2
secret /etc/openvpn/static.key
cipher AES-256-CBC
EOF

systemctl enable openvpn@server