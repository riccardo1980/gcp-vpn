# Requirements
## Configuration
- tflint, see [here](https://github.com/terraform-linters/tflint)
```Bash
tfswitch
tflint --init
terraform init
```
## Create secrets
```Bash
# check values in scripts/00-config.sh

scripts/01-prerequisites-create.sh
scripts/02-openvpn-secret.sh

```
## Deploy
```Bash
terraform plan -out tfplan
terraform apply tfplan
```
## Destroy
```Bash
terraform destroy
```
## Cleanup remote status
```Bash
scripts/99-prerequisites-destroy.sh
```
# OpenVPN configurations
## No Autentication
For test purposes only
1. sever side
```Bash
apt-get remove --purge man-db
apt-get install openvpn
```
2. create point-to-point tunnel
```Bash
openvpn --dev tun1 --ifconfig 10.9.8.1 10.9.8.2
```
3. in another terminal, check the status of device tun1
```Bash
ip a
```

### client side
1. create point-to-point tunnel
```Bash
openvpn --remote <SERVER_PUBLIC_IP> --dev tun1 --ifconfig 10.9.8.2 10.9.8.1
```
2. in another terminal, try to reach the server
```Bash
ping 10.9.8.1
traceroute 10.9.8.1
```

## Static key
1. server side

2. client side
```Bash
openvpn --remote <SERVER_PUBLIC_IP> --dev tun1 --ifconfig 10.9.8.2 10.9.8.1 --secret <CLIENT_KEY>
```
# Cloud providers
  - GCP
    - [free tier](https://cloud.google.com/free?hl=en)
    - [budget alerts](https://cloud.google.com/billing/docs/how-to/budgets)
  - Oracle 
    - [free tier](https://www.oracle.com/cloud/free/)
    - budget alerts
  - AWS
    - free tier
    - budget alerts
  - Azure
    - free tier
    - budget alerts

# References
## software install
- https://developer.hashicorp.com/terraform/tutorials/provision/cloud-init
- https://blog.entek.org.uk/notes/2021/09/29/terraform-cloud-init-and-ansible.html
- https://wiki.debian.org/OpenVPN#Installation
- https://dteslya.engineer/blog/2019/02/25/how-to-automate-openvpn-server-deployment-and-user-management/

## Similar projects
- https://github.com/dumrauf/openvpn-terraform-install
- https://github.com/DeimosCloud/terraform-google-openvpn
