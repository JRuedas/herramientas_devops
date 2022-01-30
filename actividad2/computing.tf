data "aws_ami" "jruedas_node_ami" {
  most_recent = true
  owners      = [var.ami_owner]

  filter {
    name   = "name"
    values = [var.web_ami_name]
  }

  filter {
    name   = "virtualization-type"
    values = [var.ami_virtualization_type]
  }
}

data "aws_ami" "jruedas_mongodb_ami" {
  most_recent = true
  owners      = [var.ami_owner]

  filter {
    name   = "name"
    values = [var.db_ami_name]
  }

  filter {
    name   = "virtualization-type"
    values = [var.ami_virtualization_type]
  }
}

module "ec2_web_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name                        = var.web_instance_name
  ami                         = data.aws_ami.jruedas_node_ami.id
  instance_type               = var.instance_type
  key_name                    = module.key_pair.key_pair_key_name
  vpc_security_group_ids      = [module.ssh_sg.security_group_id, module.web_server_sg.security_group_id]
  subnet_id                   = module.custom_vpc.public_subnets[0]
  associate_public_ip_address = true
  tags                        = var.tags
}

module "ec2_mongo_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name                        = var.db_instance_name
  ami                         = data.aws_ami.jruedas_mongodb_ami.id
  instance_type               = var.instance_type
  key_name                    = module.key_pair.key_pair_key_name
  vpc_security_group_ids      = [module.ssh_sg.security_group_id, module.db_server_sg.security_group_id]
  subnet_id                   = module.custom_vpc.public_subnets[0]
  associate_public_ip_address = true
  tags                        = var.tags
}