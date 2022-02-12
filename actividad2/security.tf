# Creates the SSH security group with ingress and egres rules
module "ssh_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.8.0"

  description         = "Security group with SSH ports open within VPC"
  name                = "${var.sg_prefix}_ssh"
  vpc_id              = module.custom_vpc.vpc_id
  ingress_cidr_blocks = var.sg_ingress_cidr_block
  ingress_rules       = ["ssh-tcp"]
  egress_rules        = ["all-all"]
  tags                = var.tags
}

# Creates the HTTP security group with ingress and egres rules
module "web_server_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.8.0"

  description         = "Security group with HTTP ports open within VPC"
  name                = "${var.sg_prefix}_http"
  vpc_id              = module.custom_vpc.vpc_id
  ingress_cidr_blocks = var.sg_ingress_cidr_block
  ingress_rules       = ["http-80-tcp"]
  egress_rules        = ["all-all"]
  tags                = var.tags
}

# Creates the DB security group with ingress and egres rules
module "db_server_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.8.0"

  description         = "Security group with Mongo ports open within VPC"
  name                = "${var.sg_prefix}_mongo"
  vpc_id              = module.custom_vpc.vpc_id
  ingress_cidr_blocks = var.sg_ingress_cidr_block
  ingress_rules       = ["mongodb-27017-tcp"]
  egress_rules        = ["all-all"]
  tags                = var.tags
}