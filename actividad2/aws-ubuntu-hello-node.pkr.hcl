packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu-jonatan" {
  instance_type          = "t2.micro"
  region                 = "us-east-1"
  source_ami             = "ami-0230aba74330fed22"
  ssh_username           = "ubuntu"
  profile                = "personal"
  skip_region_validation = true
}

build {
  name = "node-app"

  source "amazon-ebs.ubuntu-jonatan" {
    ami_name = "hello-node-jonatan"
  }

  provisioner "ansible" {
    playbook_file = "./node-playbook.yaml"
  }

  provisioner "ansible" {
    playbook_file = "./nginx-playbook.yaml"
  }
}

build {
  name = "mongodb"

  source "amazon-ebs.ubuntu-jonatan" {
    ami_name = "mongodb-jonatan"
  }

  provisioner "ansible" {
    playbook_file = "./mongodb-playbook.yaml"
  }
}