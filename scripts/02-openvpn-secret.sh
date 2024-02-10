#!/usr/bin/env bash

set -e

KEYFILE = "secrets/static.key"

 openvpn --genkey secret $KEYFILE