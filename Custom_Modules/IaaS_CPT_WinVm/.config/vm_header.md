# Module Azure Application Gateway

This module is used to provision an Azure Windows Virtual Machine and related resources

## Module description

This module deploys an Azure VM with Windows OS
It includes configuration for:

- Azure Virtual Machine
- Network Interface Card
- Application Security Group and its association with the nic
- Azure diagnostic settings for Nic
- VM extension for AD DS join
- VM extension for Entra Id Authentication
- VM extension for custom script

