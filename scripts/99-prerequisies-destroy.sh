#!/usr/bin/env bash
set -e

. scripts/00-config.sh

echo "Destroying Service Account"
# gcloud iam service-accounts delete ${SERVICE_ACCOUNT}@$PROJECT_ID.iam.gserviceaccount.com

echo "Destroying Cloud Storage Bucket"
gsutil rm -r gs://$STATE_BUCKET