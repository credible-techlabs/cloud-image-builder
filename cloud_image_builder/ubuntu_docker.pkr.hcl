packer {
  required_plugins {
    azure = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/azure"
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
  os_type            = "Linux"
  image_publisher    = "Canonical"
  image_offer        = "UbuntuServer"
  image_sku          = "18.04-LTS"
  location     = "eastus"
  managed_image_name = "ubuntu-docker-nginx-image"
  managed_image_resource_group_name = "myResourceGroup"
  subscription_id    = var.azure_subscription_id
  client_id          = var.azure_client_id
  client_secret      = var.azure_client_secret
  tenant_id          = var.azure_tenant_id
}

build {
  sources = ["source.azure-arm.ubuntu"]

  provisioner "ansible" {
    playbook_file = "./playbooks/docker-install.yml"
  }

  provisioner "ansible" {
    playbook_file = "./playbooks/nginx-install.yml"
  }
}
