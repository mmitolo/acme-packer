## Terraform & Packer demo

Welcome to the Terraform & Packer demo repository.

This repository serves as a sample Terraform and Packer configuration to automate the building of machine OS images and provision cloud resources accross AWS and GCP cloud providers.
### Requirements

 * [Packer](https://developer.hashicorp.com/packer/install?product_intent=packer) - Tested version v1.10.2
 * [Terraform](https://developer.hashicorp.com/terraform/install) - Tested version v1.7.5
 * [HCP account](https://portal.cloud.hashicorp.com/sign-in)
 * [Terraform cloud account](https://app.terraform.io/public/signup/account?product_intent=terraform)
 * Access to GCP and AWS cloud providers

#### Terraform providers

 * [hashicorp/aws](https://registry.terraform.io/providers/hashicorp/aws/latest) v5.40.0
 * [hashicorp/hcp](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs) v0.82.0
 * [hashicorp/google](https://registry.terraform.io/providers/hashicorp/google/latest) v5.21.0
 * [hashicorp/google-beta](https://registry.terraform.io/providers/hashicorp/google-beta/latest) v5.21.0
 * [hashicorp/null](https://registry.terraform.io/providers/hashicorp/null/latest) v3.2.2

#### Packer builder plugins

 * [amazon-ebs](https://developer.hashicorp.com/packer/integrations/hashicorp/amazon) v1.3.1
 * [googlecompute](https://developer.hashicorp.com/packer/integrations/hashicorp/googlecompute) v1.1.3

## Usage

### Packer

 1. Export `HCP_CLIENT_ID` and `HCP_CLIENT_SECRET` variables to be able to login to the HCP portal.
 2. Export AWS credentials as environment variables or inside your credentials file at `$HOME/.aws/` folder
 3. Authenticate in your GCP account via your CLI, get the path of your json credentials file, and export the `GOOGLE_APPLICATION_CREDENTIALS` with this file credentials.
 4. Run `cd packer` && `packer init .` to initialize your working environment with the corresponding builders
 5. Run `packer build .` to trigger an OS image building process for AWS and GCP clouds simultaneously.

### Terraform

**Initial setup**

 1. Login in Terraform Cloud
 2. Create an organization to structure your workspaces and projects layout according to your needs.
 3. Setup two workspaces: One workspace destined to AWS resources, one for GCP resources.
 4. Create a variable set for AWS and insert AWS execution variables according to your access level and privileges in your AWS account.
 5. Create a variable set for GCP and insert GCP execution variables according to your access level and privileges in your GCP account.

**Execution**

 1. Export AWS credentials as environment variables or inside your credentials file at `$HOME/.aws/` folder
 2. Authenticate in your GCP account via your CLI, get the path of your json credentials file, and export the `GOOGLE_APPLICATION_CREDENTIALS` with this file credentials.
 3. Run `terraform init` to set up your working environment with the correct providers
 4. Create a `terraform.tfvars` from the empty `terraform.tfvars.clear` file with the corresponding values of each cloud provider.
 4. Run `terraform fmt` and `terraform validate` to update your hcl files format and check for syntax and validation errors.
 6. Run `terraform plan` and `terraform apply`. Review the execution plan to understand if the resources to be deployed match your configuration.

