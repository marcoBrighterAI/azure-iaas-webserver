# Azure Infrastructure Operations Project
Deploying a scalable IaaS web server in Azure.

### Introduction
This project, contains a Packer template, and a Terraform template to deploy a customizable, scalable web server in Azure.
It uses Packer to create the server image, and Terraform for deploying a scalable cluster of servers—with a load balancer
to manage the incoming traffic. It also adheres to the security best practices ensuring that the infrastructure is secure.

### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions
1. Clone this repository
2. Create a Service Principle for Packer and Terraform
3. Create a Resource Group for the Packer image
4. Deploy the packer image
5. Deploy the infrastructure with Terraform

#### 1. Clone this repository
``` 
    git clone https://github.com/marcoBrighterAI/azure-iaas-webserver.git
```

#### 2. Create a Service Principle for Packer and Terraform
Log into your Azure account
``` bash
    az login 
```

``` bash 
    az account set --subscription="SUBSCRIPTION_ID"
```
Create Service Principle
``` bash
    az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID"
```

This command will output 5 values:
``` json
{
  "appId": "00000000-0000-0000-0000-000000000000",
  "displayName": "azure-cli-2017-06-05-10-41-15",
  "name": "http://azure-cli-2017-06-05-10-41-15",
  "password": "0000-0000-0000-0000-000000000000",
  "tenant": "00000000-0000-0000-0000-000000000000"
}
``` 
Create a .env.sh file inside the packer directory and copy the content of the .env.sh.template to the newly created file.
Change the parameters based on the output of the previous command. These values map to the .evn.sh variables like so:

    appId is the ARM_CLIENT_ID
    password is the ARM_CLIENT_SECRET
    tenant is the ARM_TENANT_ID

For more information about *Authenticating to Azure using a Service Principal and a Client Secret*
(follow this [Guide](https://www.terraform.io/docs/providers/azurerm/guides/service_principal_client_secret.html))

#### 3. Create a Resource Group for the Packer image
Create Resource Group
``` bash
    az group create -l "LOCATION" -n "RESOURCE_GROUP_NAME" --tags udacity=udacity-project1
```
Ensure that the *location* and *resource group* that you specify here is the same specified in [server.json](packer/server.json).

#### 4. Deploy the packer image
Source environment variables 
```
    source packer/.env.sh
```
Run packer file
```
    packer build ./packer/server.json
```
This will create a packer image in the *resource group* specified in the previous step.

#### 5. Deploy the infrastructure with Terraform
Edit variables in the [variables.tf](terraform/variables.tf) to reflect your desired infrastructure.

The following items should be updated accordingly:

- prefix
- location (should match packer image location)
- username
- password
- image_id
- instance_count

Run Terraform plan 
``` bash
    cd terraform/
```
``` bash
    terraform init
```
``` bash
    terraform plan
```
After running the plan you should see all the resources that will be created.

Run Terraform apply
``` bash
    terraform apply
```

### Output
Service Principal with permissions to manage resources in the specified Subscription:

- [Azure Service Principal](https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/RegisteredApps)

Packer creates the following resources:

- [Image resource group](https://portal.azure.com/#blade/HubsExtension/BrowseResourceGroups)
- [Managed virtual machine image](https://portal.azure.com/#blade/HubsExtension/BrowseResource/resourceType/Microsoft.Compute%2Fimages)

Terraform creates the following resources:

- Availability Set
- Azure Managed Disk(s)
- Load Balancer
- Network Interface Card(s)
- Network Security Group
- Public IP
- Virtual Machine(s)

All can be found under the specified [resource group](https://portal.azure.com/#blade/HubsExtension/BrowseResourceGroups).
