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

variable "ami_id" {
  description = "AMI identifier that will be used. Ubutun 18.04 from Amazon."
  type        = string
  default     = "ami-04692e32290cb200e"
}

// EC2 instance variables.

variable "apollo_instance_type" {
  description = "Type of the AWS EC2 instance that will be created for the Apollo server."
  type        = string
  default     = "t2.micro"
}

variable "elasticsearch_instance_type" {
  description = "Type of the AWS EC2 instance that will be created for the ElasticSearch server."
  type        = string
  default     = "t2.medium"
}

// VPC variables.

variable "vpc_cidr" {
  description = "CIDR block for AWS VPC."
  type        = string
  default     = "192.168.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for AWS public subnet"
  type        = string
  default     = "192.168.1.0/24"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    Owner = "Actividad3"
  }
}

// SSH Key pair variables.

variable "key_name" {
  description = "Name of the AWS Key Pair that will be created."
  type        = string
  default     = "actividad3-key"
}

variable "key_algorithm" {
  description = "Algorithm of the AWS Key Pair."
  type        = string
  default     = "RSA"
}

// Operating system user

variable "so_user" {
  description = "SO user."
  type        = string
  default     = "ubuntu"
}