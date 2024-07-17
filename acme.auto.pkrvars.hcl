project_id   = "hc-f25ec0d44b3145959f3d781b5e7"
gcp_vpc_zone = "us-central1-a"
builder_sa   = ""
aws_region   = "us-west-2"
aws_profile  = "acme_aws_demo"
aws_vpc_parent_network = {
  vpc_id    = "vpc-0984e2ddaf3a1b7fa"
  subnet_id = "subnet-08fa9733d4823d88f"
}
new_image_name = "acmeimage"
version        = "v01"
app_name       = "static-demo"


gcp_packer_src = {
  source_image_family = "ubuntu-pro-2204-lts"
  image_description   = "ACME image built with HashiCorp Packer for GCP"
  ssh_username        = "ubuntu"
  tags                = ["packer"]
  machine_type        = "e2-standard-4"
  use_iap             = true
  use_os_login        = false
  metadata            = { enable-oslogin : "true" }
}

aws_packer_src = {
  image_virtualization_type = "hvm"
  image_name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
  root_device_type          = "ebs"
  owners                    = ["099720109477"]
  most_recent               = true
  ami_description           = "ACME image built with HashiCorp Packer for AWS"
  instance_type             = "t3.large"
  ssh_username              = "ubuntu"
  ssh_agent_auth            = false
}