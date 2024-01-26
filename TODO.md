# software install
- https://developer.hashicorp.com/terraform/tutorials/provision/cloud-init
- https://blog.entek.org.uk/notes/2021/09/29/terraform-cloud-init-and-ansible.html
- https://wiki.debian.org/OpenVPN#Installation

# SEE ALSO
- https://github.com/dumrauf/openvpn-terraform-install
- https://github.com/DeimosCloud/terraform-google-openvpn

REMEMBER: disable mandb

- from https://wiki.debian.org/OpenVPN
# sever side
apt-get remove --purge man-db
apt-get install openvpn
# create point-to-point tunnel
openvpn --dev tun1 --ifconfig 10.9.8.1 10.9.8.2
# in another terminal, check the status of device tun1
ip a

# client side
# create point-to-point tunnel
openvpn --remote <SERVER_PUBLIC_IP> -dev tun1 --ifconfig 10.9.8.2 10.9.8.1
# in another terminal, try to reach the server
ping 10.9.8.2

---------------
# fixme
- still duplicated values for resources
  - project: terraform.tfvars, PROJECT_ID: scripts/00-config.sh
  - region: terraform.tfvars, REGION: scripts/00-config.sh
  - bucket: backend.tf, STATE_BUCKET: 00-config.sh
