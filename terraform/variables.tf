variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  default     = "iaas-webserver"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "West Europe"
}

variable "username" {
  description = "The User Name for the virtual machine"
  default     = "developer"
}

variable "password" {
  description = "The password for the virtual machine"
  default     = "Developer1234"
}

variable "image_id" {
  description = "Enter the ID for the image which will be used for creating the Virtual Machines"
  default     = "/subscriptions/SUBSCRIPTION_ID/resourceGroups/RESOURCE_GROUP_NAME/providers/Microsoft.Compute/images/IMAGE_NAME"
}

variable "instance_count" {
  description = "Enter number of vm instances to create"
  default     = "2"
}
