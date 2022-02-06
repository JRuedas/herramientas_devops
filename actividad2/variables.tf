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

// EC2 instance variables.

variable "instance_type" {
  description = "Type of the AWS EC2 instance that will be created."
  type        = string
  default     = "t2.micro"
}

variable "web_instance_name" {
  description = "Name of the AWS EC2 web instance that will be created."
  type        = string
  default     = "web_instance"
}

variable "db_instance_name" {
  description = "Name of the AWS EC2 database instance that will be created."
  type        = string
  default     = "database_instance"
}

variable "db_private_ip" {
  description = "Private IP of the AWS EC2 database instance that will be created."
  type        = string
  default     = "192.168.1.1"
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