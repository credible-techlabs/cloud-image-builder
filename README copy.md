# Azure Ubuntu Image with Docker and Nginx

This project uses Packer and Ansible to create an Ubuntu VM image in Azure with Docker and Nginx pre-installed. The image is then published to Azure as a managed image.

## Folder Structure
- `.github/workflows`: Contains the GitHub Actions workflow for CI/CD.
- `playbooks`: Contains Ansible playbooks for installing Docker and Nginx.
- `ubuntu_docker.pkr.hcl`: The Packer template used to build the image.

## How to Use

### 1. GitHub Secrets
Add the following secrets to your GitHub repository:
- `AZURE_CREDENTIALS`: Azure service principal credentials in JSON format.
  
### 2. Triggering the Build
Push to the `main` branch to trigger the GitHub Actions workflow, which will:
- Run the Packer build process.
- Create a managed image in Azure with Docker and Nginx installed.

### 3. Customization
You can modify the Ansible playbooks in the `playbooks/` directory to install additional software.
