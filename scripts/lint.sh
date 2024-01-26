#!/usr/bin/env bash

set -e

terraform fmt
tflint
terraform validate