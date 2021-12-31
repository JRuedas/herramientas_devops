packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "hello-node-jonatan" {
  ami_name               = "hello-node-jonatan"
  instance_type          = "t2.micro"
  region                 = "us-east-1"
  source_ami             = "ami-0230aba74330fed22"
  ssh_username           = "ubuntu"
  profile                = "upm"
  skip_region_validation = true
}

build {
  source "amazon-ebs.hello-node-jonatan" {}

  provisioner "ansible" {
    playbook_file = "./node-playbook.yaml"
  }

  provisioner "ansible" {
    playbook_file = "./nginx-playbook.yaml"
  }

  provisioner "ansible" {
    playbook_file = "./metrics-playbook.yaml"
  }


  post-processor "manifest" {
    output = "output.json"
  }
}
