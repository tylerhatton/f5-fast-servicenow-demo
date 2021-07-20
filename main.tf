locals {
  name_prefix = var.name_prefix
  default_tags = {
    Terraform = "true"
    Owner     = var.owner
  }
}

provider "servicenow" {
  instance_url = var.servicenow_url
  username     = var.servicenow_username
  password     = var.servicenow_password
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.0.0"

  name           = "${local.name_prefix}-vpc"
  cidr           = "10.128.0.0/16"
  azs            = [data.aws_availability_zones.available.names[0]]
  public_subnets = ["10.128.10.0/24"]

  tags = local.default_tags
}

module "bigip" {
  source       = "./modules/bigip"
  default_tags = local.default_tags
  name_prefix  = local.name_prefix
  vpc_id       = module.vpc.vpc_id
  subnet_id    = module.vpc.public_subnets[0]
}

module "nginx" {
  source         = "./modules/nginx"
  vpc_id         = module.vpc.vpc_id
  subnet_id      = module.vpc.public_subnets[0]
  instance_count = 5
  default_tags   = local.default_tags
  name_prefix    = local.name_prefix
}

module "servicenow" {
  source             = "./modules/servicenow"
  bigip_public_ip    = module.bigip.bigip_public_ip
  bigip_username     = module.bigip.admin_username
  bigip_password     = module.bigip.admin_password
  server_private_ips = module.nginx.private_ips
  server_names       = module.nginx.names
}
