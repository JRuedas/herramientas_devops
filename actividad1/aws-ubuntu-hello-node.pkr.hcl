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
  // vpc_id                 = "vpc-xxxxxxxx"
  // subnet_id              = "subnet-xxxxxxxx"
  // associate_public_ip_address = "true"
  ssh_username           = "ubuntu"
  profile                = "jruedas"
  skip_region_validation = true
}

build {
  source "amazon-ebs.hello-node-jonatan" {}

  provisioner "file" {
    source      = "hello-jruedas-node.js"
    destination = "/tmp/hello-jruedas-node.js"
  }

  provisioner "shell" {
    script = "provision_image.sh"
  }

  post-processor "manifest" {
    output = "output.json"
  }
}
