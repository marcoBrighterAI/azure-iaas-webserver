variable "prefix" {
  description = "The prefix which should be used for all resources in this example"
  default     = "udacity"
}

variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "westeurope"
}

variable "username" {
  description = "The User Name for the virtual machine"
  default     = "developer"
}

variable "password" {
  description = "The password for the virtual machine"
  default     = "password1234"
}

variable "image_id" {
  description = "Enter the ID for the image which will be used for creating the Virtual Machines"
  default     = "/subscriptions/4d9228ff-49b1-44de-b0c7-887cc3983264/resourceGroups/udacity-project1-rg/providers/Microsoft.Compute/images/packer-image"
}

variable "instance_count" {
  description = "Enter number of vm instances to create"
}
