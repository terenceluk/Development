variable "brand" {
  type        = string
  description = "Company Brand"
  default     = "ctc"
}

variable "location" {
  type        = string
  description = "Azure location"
  default     = "Canada Central"
}

variable "environment" {
  type        = string
  description = "Which enviroment sandbox nonprod prod"
  default     = "sandbox"
}

variable "resource_group_name" {
  type        = string
  description = "The resource group name where the VM will be deployed."
  default     = null
}

variable "subnet_name" {
  type        = string
  description = "Specify the Subnet name which needs to be connect to the AkS cluster"
  default     = null
}

variable "vnet_name" {
  type        = string
  description = "Specify the VNET or leave null to get a vnet based on environment variable"
  default     = null
}

variable "vnet_rg" {
  type        = string
  description = "Specify the VNET resource group or leave null to get a vnet based on environment variable"
  default     = null
}

variable "override_resource_group_name" {
  type        = string
  description = "This will override the auto naming convention for the resource group."
  default     = null
}

variable "project_name" {
  type        = string
  description = "(Required)The project name"
  default     = null
}

variable "short_description" {
  description = "Three-seven character identifier used in the hostnames to identitify the virtual machines. Example p9icaz\"short_description\"01"
  type        = string
  default     = null
}

variable "shared_image" {
  description = "Provide the Shared Image Gallery image info"
  type = object({
    image_name         = string,
    image_gallery_name = string,
    image_gallery_rg   = string,
  })

  default = null
}

variable "marketplace_image" {
  description = "Provide the marketplace image info"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = null
}

variable "plan" {
  description = "Provide the marketplace image plan info"
  type = object({
    name      = string
    publisher = string
    product   = string
  })
  default = null
}

variable "shared_image_id" {
  description = "Use a specific Shared Image using the full ID"
  type        = string
  default     = null
}

variable "os_flavor" {
  type        = string
  default     = "linux"
  description = "Specify the flavour of the operating system image to deploy VM. Valid values are `Ubuntu` and `linux`"
}

variable "generate_admin_ssh_key" {
  description = "Generates a secure private key and encodes it as PEM."
  default     = true
}

variable "admin_ssh_key_data" {
  description = "specify the path to the existing ssh key to authenciate linux vm if generate ssh key is set to false"
  default     = ""
}

variable "availability_zone" {
  description = "A list of Availability Zones in which the Virtual Machines in this Scale Set should be created in"
  type        = string
  default     = null
}

variable "virtual_machine_size" {
  description = "(Required) The SKU which should be used for this Virtual Machine, such as Standard_F2"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "additional_data_disks" {
  description = "Adding additional disks capacity to add each instance (GB)"

  default = []
  type = list(object({
    disk_size            = string,
    caching              = string,
    create_option        = string,
    storage_account_type = string,
  }))
}

variable "os_disk_size_gb" {
  description = "The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from."
  type        = string
  default     = null
}

variable "enable_accelerated_networking" {
  description = "(Optional) Should Accelerated Networking be enabled?"
  type        = string
  default     = "false"
}

variable "private_ip_address" {
  description = "The Static IP Address which should be used. If not set will use DHCP"
  type        = string
  default     = null
}

variable "os_disk_type" {
  description = "The type of storage to use for the OS managed disk. Possible values are Standard_LRS, Premium_LRS, StandardSSD_LRS"
  default     = "StandardSSD_LRS"
  type        = string
}

variable "os_disk_caching" {
  default     = "ReadOnly"
  type        = string
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite"
}

variable "ultra_ssd_enabled" {
  type        = string
  default     = "false"
  description = "Should the capacity to enable Data Disks of the UltraSSD_LRS storage account type be supported on this Virtual Machine Scale Set? Defaults to false"
}

variable "diff_disk_settings" {
  type        = bool
  default     = false
  description = "Enables the diff disk setting. Currently only Local is supported"
}

variable "existing_avset_id" {
  description = "Specifies the ID of the Availability Set in which the Virtual Machine should exist. Changing this forces a new resource to be created. If one is not specified it will be created"
  type        = string
  default     = null
}

variable "is_dev" {
  description = "Is this VM for a dev environment"
  type        = string
  default     = false
}

variable "deploy_log_analytics_agent" {
  description = "Provide the workspace ID and the workspace Key to install the log analytics agent."
  type = object({
    workspace_id  = string
    workspace_key = string
  })
  default = null
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}

variable "vm_name_override" {
  description = "Override the default naming convention for the VM resource"
  type        = string
  default     = null
}

variable "custom_extension" {
  description = "A custom extension block"
  type = object({
    publisher            = string
    type                 = string
    type_handler_version = string
    settings             = map(any)
    protected_settings   = map(any)
  })
  default = null
}

variable "vm_name_suffix" {
  type        = string
  description = "The suffix that should be used for this machine. This value needs to change if multple VMs are create that share the same short description."
  default     = 1
}

variable "existing_boot_diagnostics_storage_account_uri" {
  type        = string
  description = "Storage account URI for boot diagnostics"
  default     = null
}

variable "recovery_services_vault" {
  description = "The name of the pre-existing Recovery Service Vault and the resource group name that contains the backup policy being applied to these VMs"
  default     = null
  type = object({
    name                = string
    resource_group_name = string
    backup_policy_name  = string
  })
}

variable "backup_policy" {
  description = "The name of the pre-existing backup policy being applied to these VMs"
  default     = null
  type = object({
    backup_policy_name = string

  })
}

variable "domain_name" {
  description = "The Infoblox DNS domain name where the VM should be registered. Example `corp.azure.ctc`."
  type        = string
}

variable "boot_diag" {
  description = "Boot Diagnostic Storage Account Configurable options"
  type = object({
    enable_privatelink = bool,
    default_action     = string,
    ip_rules           = list(string)
    vault_type         = string,
  })

  default = {
    enable_privatelink = false,
    default_action     = "Deny",
    ip_rules           = []
    vault_type         = "hashicorp"
  }
}

variable "avset_platform_fault_domain_count" {
  description = "Specifies the number of update domains that are used. Defaults to 3. Changing this forces a new resource to be created."
  type        = string
  default     = 3
}

variable "avset_platform_update_domain_count" {
  description = "Specifies the number of fault domains that are used. Defaults to 5. Changing this forces a new resource to be created."
  type        = string
  default     = 5
}

variable "key_vault_id" {
  description = "The ID of the custom Key Vault where the Secret should be created."
  type        = string
  default     = null
}

variable "vault_type" {
  type        = string
  description = "Specifies which Vault type will this resource store its secrets. Possible values: 'hashicorp', 'akv', 'none'."
  default     = "akv"

  validation {
    condition     = contains(["none", "akv", "hashicorp"], var.vault_type)
    error_message = "Allowed values for 'vault_type' are: 'none', 'akv', 'hashicorp'."
  }
}

variable "secrets" {
  description = "Generate secrets for VM"
  type        = any
  default     = {}
}

variable "identity_type" {
  type        = string
  description = "The type of identity used for the managed cluster. Possible values are `SystemAssigned`, `UserAssigned`."
  default     = "SystemAssigned"
}

variable "identity_ids" {
  type        = any
  description = "The ID of a user assigned identity."
  default     = []
}

variable "vm_user_login_assignments" {
  description = "The list of ID of the Principal (User, Group or Service Principal) to assign the Role Definition to. Changing this forces a new resource to be created. This role assignment will assign Standard User privileges to the VM."
  type        = list(string)
  default     = []
}

variable "vm_admin_login_assignments" {
  description = "The list of ID of the Principal (User, Group or Service Principal) to assign the Role Definition to. Changing this forces a new resource to be created. This role assignment will assign Administrator privileges to the VM."
  type        = list(string)
  default     = []
}

variable "managed_disk" {
  description = "A managed disk block for the replication VM"
  type        = map(any)
  default     = {}
}

variable "vm_replication" {
  description = "VM replication block with the parameters required for replication creation"
  type = map(object({
    name                                      = string
    recovery_vault_resource_group_name        = string
    recovery_vault_name                       = string
    source_recovery_fabric_name               = string
    recovery_replication_policy_id            = string
    source_recovery_protection_container_name = string
    target_resource_group_id                  = string
    target_recovery_fabric_id                 = string
    target_recovery_protection_container_id   = string
  }))
  default = {}
}

variable "enable_replication" {
  description = "To enable replication for windows VM"
  type        = bool
  default     = false
}

variable "target_subnet_name" {
  description = "Name of the subnet to to use when a failover is done"
  type        = string
  default     = null
}