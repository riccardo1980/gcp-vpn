#!/usr/bin/env bash

set -e

# formatting
terraform fmt

# validation
tflint
terraform validate