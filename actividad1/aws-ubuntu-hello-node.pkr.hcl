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
  profile                = "default"
  skip_region_validation = true
}

source "amazon-ebs" "mongodb-jonatan" {
  ami_name               = "mongodb-jonatan"
  instance_type          = "t2.micro"
  region                 = "us-east-1"
  source_ami             = "ami-0230aba74330fed22"
  ssh_username           = "ubuntu"
  profile                = "default"
  skip_region_validation = true
}

source "azure-arm" "hello-node-jonatan" {
  subscription_id = "your_subscription_id"

  managed_image_resource_group_name = "hello-node-jonatan"
  managed_image_name                = "hello-node-jonatan"

  os_type         = "Linux"
  image_publisher = "Canonical"
  image_offer     = "UbuntuServer"
  image_sku       = "18.04-LTS"

  ssh_username = "ubuntu"
  location     = "East US"
  vm_size      = "Standard_B1s"
}

build {
  source "amazon-ebs.hello-node-jonatan" {}

  source "azure-arm.hello-node-jonatan" {}

  provisioner "ansible" {
    playbook_file = "./node-playbook.yaml"
  }

  provisioner "ansible" {
    playbook_file = "./nginx-playbook.yaml"
  }

  provisioner "ansible" {
    playbook_file = "./metrics-playbook.yaml"
  }
}

build {
  source "amazon-ebs.mongodb-jonatan" {}

  provisioner "ansible" {
    playbook_file = "./mongodb-playbook.yaml"
  }
}