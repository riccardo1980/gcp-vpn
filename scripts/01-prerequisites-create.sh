#!/usr/bin/env bash
set -e

. scripts/00-config.sh

gcloud config set project ${PROJECT_ID}

# SERVICE ACCOUNT
echo "Creating service account..."
gcloud iam service-accounts create ${SERVICE_ACCOUNT} \
    --description="Terraform Service account Demo Sandbox Environment" \
    --display-name="Terraform Service Account"

echo "Adding policy binding..."
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member="serviceAccount:${SERVICE_ACCOUNT}"@${PROJECT_ID}.iam.gserviceaccount.com \
    --role="roles/editor"

echo "Creating and downloading keys..."
gcloud iam service-accounts keys create ./secrets/terraform-service-account.json \
    --iam-account=${SERVICE_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com

# STORAGE BUCKET
echo "Creating storage bucket..."
gsutil mb -l europe-west1 gs://${STATE_BUCKET}
