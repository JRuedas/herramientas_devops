resource "tls_private_key" "this" {
  algorithm = var.key_algorithm
  rsa_bits  = "4096"
}

module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = var.key_name
  public_key = tls_private_key.this.public_key_openssh
  tags       = var.tags
}

resource "local_file" "ssh_key" {
  filename        = "${module.key_pair.key_pair_key_name}.pem"
  file_permission = "400"
  content         = tls_private_key.this.private_key_pem
}