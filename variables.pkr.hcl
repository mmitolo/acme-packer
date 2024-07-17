variable "project_id" {
  type = string
}

variable "gcp_vpc_zone" {
  type = string
}

variable "builder_sa" {
  type = string
}

variable "version" {
  type = string
}

variable "app_name" {
  type = string
}

variable "gcp_packer_src" {
  type = object({
    source_image_family = string
    image_description   = string
    ssh_username        = string
    tags                = list(string)
    machine_type        = string
    use_iap             = bool
    use_os_login        = bool
    metadata            = object({})
  })
}

variable "aws_packer_src" {
  type = object({
    image_virtualization_type = string
    image_name                = string
    root_device_type          = string
    owners                    = list(string)
    most_recent               = bool
    ami_description           = string
    instance_type             = string
    ssh_username              = string
    ssh_agent_auth            = string
  })
}

variable "aws_vpc_parent_network" {
  type = object({
    vpc_id    = string
    subnet_id = string
  })
}

variable "aws_region" {
  type = string
}

variable "aws_profile" {
  type = string
}

variable "new_image_name" {
  type = string
}