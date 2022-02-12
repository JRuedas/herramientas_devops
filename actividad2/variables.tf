# AWS Provider

variable "aws_profile" {
  description = "AWS profile that will be used to create the infrastructure."
  type        = string
  default     = "default"
}

variable "aws_region" {
  description = "AWS region where the infrastructure will be created."
  type        = string
  default     = "us-east-1"
}

// AMI variables.

variable "ami_owner" {
  description = "Owner of the AWS AMI that will be used."
  type        = string
  default     = "self"
}

variable "web_ami_name" {
  description = "Name of the AWS web AMI that will be used."
  type        = string
  default     = "hello-node-jonatan"
}

variable "db_ami_name" {
  description = "Name of the AWS database AMI that will be used."
  type        = string
  default     = "mongodb-jonatan"
}

variable "ami_virtualization_type" {
  description = "Virtualization type of the AWS AMI that will be used."
  type        = string
  default     = "hvm"
}

// Autoscaling group variables.

variable "autoscaling_web_name" {
  description = "Name of the AWS Autoscaling group that will be created."
  type        = string
  default     = "jruedas-asg"
}

variable "autoscaling_launch_template_description" {
  description = "Description of the AWS Launch template that will be created."
  type        = string
  default     = "Launch template example"
}

variable "autoscaling_number_of_instances" {
  description = "Number of the instances wanted for the AWS autoscaling group."
  type        = number
  default     = 2
}

// EC2 instance variables.

variable "instance_type" {
  description = "Type of the AWS EC2 instance that will be created."
  type        = string
  default     = "t2.micro"
}

variable "db_instance_name" {
  description = "Name of the AWS EC2 database instance that will be created."
  type        = string
  default     = "database_instance"
}

variable "db_private_ip" {
  description = "Private IP of the AWS EC2 database instance that will be created."
  type        = string
  default     = "192.168.1.5"
}

// VPC variables.

variable "vpc_name" {
  description = "Name of the AWS VPC that will be created."
  type        = string
  default     = "jruedas-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for AWS VPC."
  type        = string
  default     = "192.168.0.0/16"
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list(string)
  default     = ["us-east-1a"]
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC."
  type        = list(string)
  default     = ["192.168.2.0/24"]
}

variable "vpc_private_subnets" {
  description = "Private subnets for VPC."
  type        = list(string)
  default     = ["192.168.1.0/24"]
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Owner = "JRuedas"
  }
}

// Security groups variables.

variable "sg_ingress_cidr_block" {
  description = "Security Group CIDR blocks for VPC."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "sg_prefix" {
  description = "Prefix of the Security Group that will be created."
  type        = string
  default     = "jruedas_allow"
}

// SSH Key pair variables.

variable "key_name" {
  description = "Name of the AWS Key Pair that will be created."
  type        = string
  default     = "jruedas-actividad2-key"
}

variable "key_algorithm" {
  description = "Algorithm of the AWS Key Pair."
  type        = string
  default     = "RSA"
}

// ELB variables.

variable "elb_name" {
  description = "Name of the AWS ELB that will be created."
  type        = string
  default     = "jruedas-elb"
}

variable "elb_number_instances" {
  description = "Number of the AWS EC2 instances that will be balanced."
  type        = number
  default     = 2
}

// Lambda variables.

variable "function_name" {
  description = "Name of the AWS Lambda that will be created."
  type        = string
  default     = "jruedas-greetings"
}

variable "function_description" {
  description = "Description of the AWS Lambda that will be created."
  type        = string
  default     = "Hello world lambda function"
}

variable "function_handler" {
  description = "Handler of the AWS Lambda that will be created."
  type        = string
  default     = "hello.greetings"
}

variable "function_source_path" {
  description = "Source code path of the AWS Lambda that will be created."
  type        = string
  default     = "./hello.py"
}

variable "function_runtime" {
  description = "Runtime of the AWS Lambda that will be created."
  type        = string
  default     = "python3.8"
}