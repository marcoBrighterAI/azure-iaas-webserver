# Audit existing Linux VMs that use password for SSH authentication

This policy audits whether an existing Linux VM uses password instead of SSH key authentication for SSH. Once deployed, you can see the non-compliant VMs under the [Policy Compliance blade](https://ms.portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyMenuBlade/Compliance) in the Azure Portal. Note, this policy can only determine the configuration of the VM at deployment time. If changes are made to the sshd_config after the VM has been deployed, these updates will not be reflected in the ARM configuration for that VM and this policy will not be able to update its compliance for that VM.

## Deploy with Azure CLI

To deploy this policy run the following commands from the current directory.

```cli
# Create the Policy Definition (Subscription scope)
az policy definition create --name audit-existing-linux-vm-ssh-with-password --display-name "Audit existing Linux VMs that use password for SSH authentication" --description "This policy audits if a password is being used to authentication to a Linux VM" --rules azurepolicy.rules.json --mode All

# Create the Policy Assignment
# Set the scope to a resource group; may also be a subscription or management group
az policy assignment create --name 'audit-existing-linux-vm-ssh-with-password-assignment' --display-name "Audit existing Linux VMs that use password for SSH authentication Assignment" --scope /subscriptions/<subscriptionId>/resourceGroups/<resourceGroupName> --policy /subscriptions/<subscriptionId>/providers/Microsoft.Authorization/policyDefinitions/audit-existing-linux-vm-ssh-with-password
```
## Delete with Azure CLI
```cli
# Delete the Policy Assignment
az policy assignment delete --name 'audit-existing-linux-vm-ssh-with-password-assignment'

# Delete the Policy Definition
az policy definition delete --name audit-existing-linux-vm-ssh-with-password
```

## Source
[Community Policy Repo](https://github.com/Azure/Community-Policy/tree/master/Policies/Compute/audit-existing-linux-vm-ssh-with-password)