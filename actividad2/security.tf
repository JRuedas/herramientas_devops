module "ssh_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.8.0"

  description         = "Security group with SSH ports open within VPC"
  name                = "${var.sg_prefix}_ssh"
  vpc_id              = module.custom_vpc.vpc_id
  ingress_cidr_blocks = var.sg_ingress_cidr_block
  ingress_rules       = ["ssh-tcp"]
  tags                = var.tags
}

module "web_server_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.8.0"

  description         = "Security group with HTTP ports open within VPC"
  name                = "${var.sg_prefix}_http"
  vpc_id              = module.custom_vpc.vpc_id
  ingress_cidr_blocks = var.sg_ingress_cidr_block
  ingress_rules       = ["http-80-tcp"]
  tags                = var.tags
}

module "db_server_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.8.0"

  description         = "Security group with Mongo ports open within VPC"
  name                = "${var.sg_prefix}_mongo"
  vpc_id              = module.custom_vpc.vpc_id
  ingress_cidr_blocks = var.sg_ingress_cidr_block
  ingress_rules       = ["mongodb-27017-tcp"]
  tags                = var.tags
}