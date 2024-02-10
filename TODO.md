# Backlog 

## High Priority

### [OPENVPN][BUGFIX] use secret supported for both server and client side
  - client side: openvpn version 2.6.3
  - server side: openvpn [older than server]
  - client side command
    ```Bash
    openvpn --remote <SERVER_PUBLIC_IP> --dev tun1 --ifconfig 10.9.8.2 10.9.8.1 --secret <CLIENT_KEY>
    ```
  - error message
    ```
    WARNING: INSECURE cipher (BF-CBC) with block size less than 128 bit (64 bit).  This allows attacks like SWEET32.  Mitigate by using a --cipher with a larger block size
    ```

## Medium Priority

### [ALL][DOC] devise basic estimate of cloud costs

### [OPENVPN][CLEANCODE] local generation of secret and configuration
  - local creation of
    - openvpn configuration
    - openvpn secrets (this requires a local openvpn command)
  - pass files to instance, 3 options  
    1. using file-provider [last resort]  
    2. using metadata  
    3. using [cloudinit_config](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax#provisioning-files-using-cloud-config)

### [GCP][CLEANCODE] refactor local generation of secrets
  - cloud prerequisites
  - local resources
    - ssh keys
    - secrets

## Low Priority

### [OPENVPN][DOC] add missing server side key generation documentation

### [GCP][CLEANCODE] remove duplicated values for resources
  - project: terraform.tfvars, PROJECT_ID: scripts/00-config.sh
  - region: terraform.tfvars, REGION: scripts/00-config.sh
  - bucket: backend.tf, STATE_BUCKET: 00-config.sh

## Guidelines
Use semantic classification: `<status>[module][class]<[branch]>`. 

### Modules
 - GCP: google provider related
 - openvpn: openvpn related

### Classes
- TEST: add/rewrite tests
- DOC: improve documentation
- BUGFIX: fix a bug, potential bug
- FEATURE: add a feature
- CLEANCODE: improve code clarity

### Statuses
  - no status means not in development
  - :construction: `:construction:` add branch name 
  - :white_check_mark: `:white_check_mark:` means done and merged in devel 
  - no line means merged in master

Use [conventionalcommits](https://www.conventionalcommits.org/en/v1.0.0/)
