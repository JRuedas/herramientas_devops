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
    playbook_file   = "./playbook.yaml"
  }

  // provisioner "file" {
  //   source      = "hello-jruedas-node.js"
  //   destination = "/tmp/hello-jruedas-node.js"
  // }

  // provisioner "shell" {
  //   script = "provision_node.sh"
  // }

  // provisioner "file" {
  //   source      = "hello-nginx-conf"
  //   destination = "/tmp/nginx-conf"
  // }

  // provisioner "shell" {
  //   script = "provision_nginx.sh"
  // }

  post-processor "manifest" {
    output = "output.json"
  }
}
