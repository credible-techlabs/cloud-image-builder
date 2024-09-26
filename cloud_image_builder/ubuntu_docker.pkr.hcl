packer {
  required_plugins {
    azure = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/azure"
    }
  }
}

source "azure-arm" "ubuntu" {
  os_type            = "Linux"
  image_publisher    = "Canonical"
  image_offer        = "UbuntuServer"
  image_sku          = "18.04-LTS"
  azure_location     = "eastus"
  managed_image_name = "ubuntu-docker-nginx-image"
  managed_image_resource_group_name = "myResourceGroup"
  subscription_id    = "${env.ARM_SUBSCRIPTION_ID}"
  client_id          = "${env.ARM_CLIENT_ID}"
  client_secret      = "${env.ARM_CLIENT_SECRET}"
  tenant_id          = "${env.ARM_TENANT_ID}"
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
