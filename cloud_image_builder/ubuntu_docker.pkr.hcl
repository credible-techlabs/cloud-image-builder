packer {
  required_plugins {
    azure = {
      version = ">= 1.4.2"
      source  = "github.com/hashicorp/azure"
    }
    ansible = {
      source = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}


variable "azure_client_id" {
  type    = string
  default = ""
}

variable "azure_client_secret" {
  type    = string
  default = ""
}

variable "azure_tenant_id" {
  type    = string
  default = ""
}

variable "azure_subscription_id" {
  type    = string
  default = ""
}


source "azure-arm" "ubuntu" {
  image_offer                       = "0001-com-ubuntu-server-jammy"
  image_publisher                   = "canonical"
  image_sku                         = "22_04-lts"
  location                          = "East US"
  managed_image_name                = "myPackerImage"
  managed_image_resource_group_name = "myResourceGroup"
  os_type                           = "Linux"
  vm_size                           = "Standard_DS2_v2"
  
  subscription_id    = var.azure_subscription_id
  client_id          = var.azure_client_id
  client_secret      = var.azure_client_secret
  tenant_id          = var.azure_tenant_id
}

build {
  sources = ["source.azure-arm.autogenerated_1"]
  provisioner "ansible" {
    playbook_file = "playbooks/docker-install.yml"
  }

  # Second Ansible provisioner for Nginx installation
  provisioner "ansible" {
    playbook_file = "playbooks/nginx-install.yml"
  }
}