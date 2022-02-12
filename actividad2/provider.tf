# Specifies the provider parameters region and AWS CLI profile.
provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}