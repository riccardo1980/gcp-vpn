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
gcloud iam service-accounts keys create ${TERRAFORM_SA_CREDENTIALS_FILE} \
    --iam-account=${SERVICE_ACCOUNT}@${PROJECT_ID}.iam.gserviceaccount.com

# STORAGE BUCKET
echo "Creating storage bucket..."
gsutil mb -l europe-west1 gs://${STATE_BUCKET}

# SSH KEYS
echo "Creating terraform keys..."
ssh-keygen -t rsa -b 4096 -f ${TERRAFORM_SSH_PRIVATE_KEY_FILE} -N ''