PROJECT_ID="formazione-riccardo-zanella"
REGION="europe-west1"

SERVICE_ACCOUNT="terraform-service-account"
STATE_BUCKET=${PROJECT_ID}-tfstate-bucket

TERRAFORM_SA_CREDENTIALS_FILE="./secrets/terraform-service-account.json"
TERRAFORM_SSH_PRIVATE_KEY_FILE="./secrets/terraform.pem"