# Find the AMIs that will be used
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

# Create an autoscaling group for Node with the number of instances and create a launch template for those instances.
module "autoscaling_web" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 4.0"

  # Autoscaling group
  name                        = var.autoscaling_web_name
  image_id                    = data.aws_ami.jruedas_node_ami.id
  instance_type               = var.instance_type
  key_name                    = module.key_pair.key_pair_key_name
  min_size                  = var.autoscaling_number_of_instances
  max_size                  = var.autoscaling_number_of_instances
  desired_capacity          = var.autoscaling_number_of_instances
  wait_for_capacity_timeout = 0
  vpc_zone_identifier       = module.custom_vpc.public_subnets
  load_balancers            = [module.elb_http.this_elb_id]
  network_interfaces = [
    {
      subnet_id             = module.custom_vpc.public_subnets[0]
      delete_on_termination = true
      device_index          = 0
      security_groups       = [module.ssh_sg.security_group_id, module.web_server_sg.security_group_id]
      associate_public_ip_address = true
    }
  ]

  # Launch template
  lt_name                = var.autoscaling_web_name
  description            = var.autoscaling_launch_template_description
  update_default_version = true
  use_lt    = true
  create_lt = true

  tags_as_map = var.tags
}

# Creates an EC2 instance for MongoDB
module "ec2_mongo_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name                   = var.db_instance_name
  ami                    = data.aws_ami.jruedas_mongodb_ami.id
  instance_type          = var.instance_type
  key_name               = module.key_pair.key_pair_key_name
  vpc_security_group_ids = [module.ssh_sg.security_group_id, module.db_server_sg.security_group_id]
  subnet_id              = module.custom_vpc.private_subnets[0]
  private_ip             = var.db_private_ip
  tags                   = var.tags
}