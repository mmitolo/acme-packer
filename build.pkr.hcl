packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.1.5"
    }
    googlecompute = {
      version = "1.1.3"
      source  = "github.com/hashicorp/googlecompute"
    }
  }
}

locals {
  date        = formatdate("HHmm", timestamp())
  datebuild   = formatdate("HHmmss", timestamp())
  ami_regions = concat([var.aws_region], [])
}

source "googlecompute" "ubuntu_lts" {
  #impersonate_service_account = var.builder_sa
  project_id          = var.project_id
  zone                = var.gcp_vpc_zone
  source_image_family = var.gcp_packer_src.source_image_family
  image_name          = trim("${var.new_image_name}${local.date}${var.version}", "-")
  image_description   = var.gcp_packer_src.image_description
  ssh_username        = var.gcp_packer_src.ssh_username
  tags                = var.gcp_packer_src.tags
  machine_type        = var.gcp_packer_src.machine_type
  use_iap             = var.gcp_packer_src.use_iap
  use_os_login        = var.gcp_packer_src.use_os_login
  metadata            = var.gcp_packer_src.metadata
}

source "amazon-ebs" "ubuntu_lts" {
  source_ami_filter {
    filters = {
      virtualization-type = var.aws_packer_src.image_virtualization_type
      name                = var.aws_packer_src.image_name
      root-device-type    = var.aws_packer_src.root_device_type
    }
    owners      = var.aws_packer_src.owners
    most_recent = var.aws_packer_src.most_recent
  }
  region  = var.aws_region
  profile = var.aws_profile

  ami_name        = "${var.new_image_name}_${local.date}_${var.version}"
  ami_regions     = local.ami_regions
  ami_description = var.aws_packer_src.ami_description
  instance_type   = var.aws_packer_src.instance_type
  ssh_username    = var.aws_packer_src.ssh_username
  ssh_agent_auth  = var.aws_packer_src.ssh_agent_auth
}

build {
  source "source.amazon-ebs.ubuntu_lts" {
    name = "acme-ubuntu-base-image"
    #vpc_id    = var.aws_vpc_parent_network.vpc_id
    #subnet_id = var.aws_vpc_parent_network.subnet_id
    #aws_polling {
    #  delay_seconds = 25
    #  max_attempts  = 45
    #}
  }

  source "source.googlecompute.ubuntu_lts" {
    name = "acme-ubuntu-base-image"
  }

  provisioner "shell" {
    script = "scripts/setup-app.sh"
    environment_vars = [
      "APP_NAME=${var.app_name}"
    ]
  }

  # HCP Packer settings
  hcp_packer_registry {
    bucket_name = "base-ubuntu-amd64-img"
    description = "This is an image for ACME corp."

    bucket_labels = {
      "acme-corp-project" = "acme-corp-base-ubuntu-amd64",
      "os-family"         = "Ubuntu",
      "os"                = "Ubuntu Jammy 22.04 LTS"
      "team"              = "cloud-engineering"
    }
    build_labels = {
      "build-time" = local.datebuild
    }
  }
}
