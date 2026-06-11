# Lab Azure
Deploys basic infrastructure with 3 environments `(dev, qa, prod)` across 2 Azure regions using Terraform.

**!! For laboratory use only !!**
* Visible admin password
* Non-free costs

## 1. Description and use
Detailed configuration: https://github.com/gitrcr/terraform-azure/blob/main/DESCRIPTION.md

## 2. Configure in Azure Cloud:
* Open https://portal.azure.com with your labs credentials. __Cloud Express Pass (Azure)__
* Open Azure Cloud Shell (bash; no storage account needed).
* Paste this code:
```bash
# clone repo
git clone https://github.com/gitrcr/terraform-azure.git && cd terraform-azure
# init terraform
find . -name "main.tf" | xargs -I {} sh -c 'cd "$(dirname "{}")" && terraform init -upgrade'
# format files
terraform fmt -recursive
```
**Go to [## 4. Deploy project](#4-deploy-project)**

## 3. Configure in Local Infrastructure:

### 3.1 requeriments
* Terraform: https://developer.hashicorp.com/terraform/install
* Git: https://git-scm.com/install/
* Personal token RO public repos in dockerhub
* Cloud credentials for labs. **This deployment is not compatible with free accounts.**

### 3.2 clone repo
```bash
# clone repo powershell
git clone https://github.com/gitrcr/terraform-azure.git; cd terraform-azure
# bash
# git clone https://github.com/gitrcr/terraform-azure.git && cd terraform-azure
```
### 3.3 credentials and variables
Extract _Azure Contributor_ credentials in the `Azure Cloud Shell bash console`. 

You can use this script: https://github.com/gitrcr/bootstrap#tfaz-credentialssh
```bash
# azure cloud shell (bash)
bash <(wget -qO - https://raw.githubusercontent.com/gitrcr/bootstrap/refs/heads/main/terraform/tfaz-credentials.sh)
```
* Copy block between `====` markers
* Paste it into `terraform.tfvars.rename` file for all environments
* Rename the file to `terraform.tfvars`
* Rename `providers.tf.rename` to `providers.tf` (delete first)

### 3.4. initialize and format
Execute in each environment and module, or use `init-pshell.ps1` or `bash init-bash.sh`
```bash
terraform init
terraform fmt
```

## 4. Deploy project
Validate, create and apply plan, modify, update and destroy.
* Execute in each `/environment/{dev,qa,pro}`
```bash
# validate and plan
terraform validate
terraform plan -out main.tfplan
# apply plan
terraform apply main.tfplan
```
* Can modify `main.tf` and run  `terraform apply` for update changes.
* Delete deploy
```bash
# delete created objects
terraform destroy
```
