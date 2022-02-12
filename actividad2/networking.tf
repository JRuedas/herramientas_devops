# Creates the custom VPC. A public and private subnets, routes, private and public route tables, route associations, NAT gateway and Internet gateway
module "custom_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.11.5"

  name                    = var.vpc_name
  cidr                    = var.vpc_cidr
  enable_dns_hostnames    = true
  azs                     = var.vpc_azs
  public_subnets          = var.vpc_public_subnets
  private_subnets         = var.vpc_private_subnets
  map_public_ip_on_launch = false
  tags                    = var.tags
}