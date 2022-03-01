resource "aws_instance" "elasticsearch_node" {

  ami                         = var.ami_id
  instance_type               = var.elasticsearch_instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.custom-public-subnet.id
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id, aws_security_group.allow_elasticsearch_port.id, aws_security_group.allow_kibana_custom_http_port.id, aws_security_group.allow_logstash_port.id, aws_security_group.allow_apm_port.id]
  key_name                    = module.key_pair.key_pair_key_name
  private_ip                  = var.elasticsearch_ip
  tags = {
    Name = "elasticsearch"
  }

  root_block_device {
    volume_size = 20
  }

  provisioner "remote-exec" {
    inline = ["echo Connected"]

    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = var.so_user
      private_key = file(local_file.ssh_key.filename)
    }
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.so_user} -i '${self.public_ip},' --private-key ${local_file.ssh_key.filename} metrics-playbook.yaml -e aws_domain='${self.public_dns}'"
  }
}

resource "aws_instance" "apollo_node" {

  ami                         = var.ami_id
  instance_type               = var.apollo_instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.custom-public-subnet.id
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id, aws_security_group.allow_apollo_port.id]
  key_name                    = module.key_pair.key_pair_key_name
  tags = {
    Name = "apollo"
  }

  provisioner "remote-exec" {
    inline = ["echo Connected"]

    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = var.so_user
      private_key = file(local_file.ssh_key.filename)
    }
  }

  provisioner "local-exec" {
    command = "ansible-galaxy install geerlingguy.nodejs"
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.so_user} -i '${self.public_ip},' --private-key ${local_file.ssh_key.filename} node-playbook.yaml"
  }

  depends_on = [aws_instance.elasticsearch_node]
}