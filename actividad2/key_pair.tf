resource "tls_private_key" "this" {
  algorithm = var.key_algorithm
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = var.key_name
  public_key = tls_private_key.this.public_key_openssh
  tags       = var.tags
}