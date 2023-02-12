variable "brand" {
  description = "Default brand name"
  type        = string
  default     = "ctc"
}

variable "costcenter" {
  description = "Assigned cost center"
  type        = string
  default     = null
}

variable "projectcode" {
  description = "Assigned project code"
  type        = string
  default     = null
}

variable "environment" {
  description = "Which enviroment sandbox nonprod prod"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
  validation {
    condition = (
      length(var.project_name) <= 12
    )
    error_message = "Project Name shouldn't be longer then 12 Characters."
  }
}

variable "location" {
  description = "Azure location"
  type        = string
  default     = "Canada Central"
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
  default     = null
}

variable "vnet_rg" {
  description = "(Optional) Override Only - Specifies the name of the resource group the Virtual Network is located in"
  type        = string
  default     = null
}

variable "vnet_name" {
  description = "(Optional) Override Only - Specifies the name of the Virtual Network this Subnet is located within"
  type        = string
  default     = null
}

variable "subnet_name" {
  description = "(Optional) Override Only - Specifies the name of the Subnet"
  type        = string
  default     = null
}

variable "name_override" {
  description = "This variable will override the default naming convention when required"
  default     = null
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account"
  type        = string
  default     = "Standard"
}

variable "replication_override" {
  description = "(Optional) This variable will override the default replication type"
  type        = string
  default     = null
}

variable "cross_tenant_replication_enabled" {
  description = "Should cross Tenant replication be enabled?"
  type        = bool
  default     = true
}

variable "access_tier" {
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts."
  type        = string
  default     = "Hot"
}

variable "edge_zone" {
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist. Changing this forces a new Storage Account to be created."
  type        = string
  default     = null
}

variable "allow_nested_items_to_be_public" {
  description = "Allow or disallow nested items within this Account to opt into being public."
  type        = bool
  default     = false
}

variable "shared_access_key_enabled" {
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD)."
  type        = bool
  default     = true
}

variable "is_hns_enabled" {
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2. Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "nfsv3_enabled" {
  description = "Is NFSv3 protocol enabled? Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "large_file_share_enabled" {
  description = "Is Large File Share Enabled?."
  type        = bool
  default     = true
}

variable "queue_encryption_key_type" {
  description = "The encryption type of the queue service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service."
  type        = string
  default     = "Service"
}

variable "table_encryption_key_type" {
  description = "The encryption type of the table service. Possible values are Service and Account. Changing this forces a new resource to be created. Default value is Service."
  type        = string
  default     = "Service"
}

variable "infrastructure_encryption_enabled" {
  description = "Is infrastructure encryption enabled?. Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}

variable "lifecycles" {
  type        = any
  default     = []
  description = <<EOVS
  "List of maps of Azure Storage Account Management Policies
  ```
  name - (Required) A rule name can contain any combination of alpha numeric characters. Rule name is case-sensitive. It must be unique within a policy.
  enabled - (Required) Boolean to specify whether the rule is enabled.
  prefix_match - An array of strings for prefixes to be matched.
  blob_types - An array of predefined values. Valid options are blockBlob and appendBlob.
  base_blob - A map that supports the following:
    tier_to_cool_after_days - The age in days after last modification to tier blobs to cool storage. Supports blob currently at Hot tier. Must be between 0 and 99999.
    tier_to_archive_after_days - The age in days after last modification to tier blobs to archive storage. Supports blob currently at Hot or Cool tier. Must be between 0 and 99999.
    delete_after_days - The age in days after last modification to delete the blob. Must be between 0 and 99999.
  ```
  EOVS
}

variable "blob_properties" {
  type        = any
  default     = null
  description = <<EOVS
  A blob_properties (Optional) block
  ```

  type = object({
    cors_rule = list(object({
      allowed_origins    = list(string)
      allowed_methods    = list(string)
      allowed_headers    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    }))
    delete_retention_policy = object({
      days = number
    })
    change_feed_enabled     = bool
    default_service_version = string
    container_delete_retention_policy = object({
      days = number
    })
  })

  A cors_rule (Optional) block supports the following:
    allowed_headers [list(string)] - (Required) A list of headers that are allowed to be a part of the cross-origin request.
    allowed_methods [list(string)] - (Required) A list of http methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
    allowed_origins [list(string)] - (Required) A list of origin domains that will be allowed by CORS.
    exposed_headers [list(string)] - (Required) A list of response headers that are exposed to CORS clients.
    max_age_in_seconds [number] - (Required) The number of seconds the client should cache a preflight response.

  A delete_retention_policy (Optional) block supports the following:
    days [number] - (Optional) Specifies the number of days that the blob should be retained, between 1 and 365 days. Defaults to 7 

  change_feed_enabled [bool] - (Optional) Is the blob service properties for change feed events enabled? Default to false. 
  default_service_version [string] - (Optional) The API Version which should be used by default for requests to the Data Plane API if an incoming request doesn't specify an API Version. Defaults to 2020-06-12.  
 
  A container_delete_retention_policy (Optional) block supports the following:
    days [number] - (Optional) Specifies the number of days that the container should be retained, between 1 and 365 days. Defaults to 7.
  ```
  EOVS
}

variable "custom_domain" {
  type        = any
  default     = null
  description = <<EOVS
  A custom_domain (Optional) block
  ```

  type = object({
    name          = string
    use_subdomain = bool
  })

  name [string]- (Required) The Custom Domain Name to use for the Storage Account, which will be validated by Azure.  
  use_subdomain [bool] - (Optional) Should the Custom Domain Name be validated by using indirect CNAME validation?
  ```
  EOVS
}

variable "customer_managed_key" {
  type = object({
    key_vault_key_id          = string
    user_assigned_identity_id = string
  })
  default     = null
  description = <<EOVS
  A customer_managed_key (Optional) block
  ```

  type = object({
    key_vault_key_id          = string
    user_assigned_identity_id = string
  })

  key_vault_key_id [string] - (Required) The ID of the Key Vault Key, supplying a version-less key ID will enable auto-rotation of this key.
  user_assigned_identity_id [string] - (Required) The ID of a user assigned identity.
  NOTE:
  customer_managed_key can only be set when the account_kind is set to StorageV2 and the identity type is UserAssigned
  ```
  EOVS
}

variable "identity" {
  type = any
  default = {
    type         = "SystemAssigned"
    identity_ids = null
  }
  description = <<EOVS
  An identity (Optional) block
  ```

  type = object({
    type         = string
    identity_ids = list(string)
  })

  type [string] - (Required) Specifies the type of Managed Service Identity that should be configured on this Storage Account. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
  identity_ids [list(string)] - (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Storage Account.
  NOTE:
  This is required when type is set to UserAssigned or SystemAssigned, UserAssigned.
  NOTE:
  The assigned principal_id and tenant_id can be retrieved after the identity type has been set to SystemAssigned and Storage Account has been created. More details are available below.
  ```
  EOVS
}

variable "azure_files_authentication" {
  type        = any
  default     = null
  description = <<EOVS
  A azure_files_authentication block
  ```

  type = object({
    directory_type = string
    active_directory = object({
      storage_sid         = string
      domain_name         = string
      domain_sid          = string
      domain_guid         = string
      forest_name         = string
      netbios_domain_name = string
    })
  })

  directory_type [string] - (Required) Specifies the directory service used. Possible values are AADDS and AD.

  A active_directory (Optional) block supports the following:
    storage_sid [string] - (Required) Specifies the security identifier (SID) for Azure Storage.
    domain_name [string] - (Required) Specifies the primary domain that the AD DNS server is authoritative for.
    domain_sid [string] - (Required) Specifies the security identifier (SID).
    domain_guid [string] - (Required) Specifies the domain GUID.
    forest_name [string] - (Required) Specifies the Active Directory forest.
    netbios_domain_name [string] - (Required) Specifies the NetBIOS domain name.
  ```
  EOVS
}

variable "routing" {
  type        = any
  default     = null
  description = <<EOVS
  A routing (Optional) block
  ```

  type = object({
    publish_internet_endpoints  = bool
    publish_microsoft_endpoints = bool
    choice                      = string
  })

  publish_internet_endpoints [bool] - (Optional) Should internet routing storage endpoints be published? Defaults to false.
  publish_microsoft_endpoints [bool] - (Optional) Should microsoft routing storage endpoints be published? Defaults to false.
  choice [string] - (Optional) Specifies the kind of network routing opted by the user. Possible values are InternetRouting and MicrosoftRouting. Defaults to MicrosoftRouting
  ```
  EOVS
}

variable "queue_properties" {
  type        = any
  default     = null
  description = <<EOVS
  A queue_properties (Optional) block
  ```

  type = object({
    cors_rule = list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    }))

    logging = object({
      delete                = bool
      read                  = bool
      version               = string
      write                 = bool
      retention_policy_days = number
    })

    minute_metrics = object({
      enabled               = bool
      version               = string
      include_apis          = bool
      retention_policy_days = number
    })

    hour_metrics = object({
      enabled               = bool
      version               = string
      include_apis          = bool
      retention_policy_days = number
    })
  })

  A cors_rule block (Optional) supports the following:
    allowed_headers [list(string)] - (Required) A list of headers that are allowed to be a part of the cross-origin request.
    allowed_methods [list(string)] - (Required) A list of http methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
    allowed_origins [list(string)] - (Required) A list of origin domains that will be allowed by CORS.
    exposed_headers [list(string)] - (Required) A list of response headers that are exposed to CORS clients.
    max_age_in_seconds [number] - (Required) The number of seconds the client should cache a preflight response.

  A logging (Optional) block supports the following:
    delete [bool] - (Required) Indicates whether all delete requests should be logged. Changing this forces a new resource.
    read [bool] - (Required) Indicates whether all read requests should be logged. Changing this forces a new resource.
    version [string] - (Required) The version of storage analytics to configure. Changing this forces a new resource.
    write [bool] - (Required) Indicates whether all write requests should be logged. Changing this forces a new resource.
    retention_policy_days [number] - (Optional) Specifies the number of days that logs will be retained. Changing this forces a new resource.

  A minute_metrics (Optional) block supports the following:
    enabled [bool] - (Required) Indicates whether minute metrics are enabled for the Queue service. Changing this forces a new resource.
    version [string] - (Required) The version of storage analytics to configure. Changing this forces a new resource.
    include_apis [bool] - (Optional) Indicates whether metrics should generate summary statistics for called API operations.
    retention_policy_days [number] - (Optional) Specifies the number of days that logs will be retained. Changing this forces a new resource.

  A hour_metrics (Optional) block supports the following:
    enabled [bool] - (Required) Indicates whether hour metrics are enabled for the Queue service. Changing this forces a new resource.
    version [string] - (Required) The version of storage analytics to configure. Changing this forces a new resource.
    include_apis [bool] - (Optional) Indicates whether metrics should generate summary statistics for called API operations.
    retention_policy_days [number] - (Optional) Specifies the number of days that logs will be retained. Changing this forces a new resource.
  ```
  EOVS
}

variable "share_properties" {
  type        = any
  default     = null
  description = <<EOVS
  A share_properties block
  ```

  type = object({
    cors_rule = list(object({
      allowed_headers    = list(string)
      allowed_methods    = list(string)
      allowed_origins    = list(string)
      exposed_headers    = list(string)
      max_age_in_seconds = number
    }))

    retention_policy = object({
      days = number
    })

    smb = object({
      versions                        = list(string)
      authentication_types            = list(string)
      kerberos_ticket_encryption_type = list(string)
      channel_encryption_type         = list(string)
    })
  })

  A cors_rule (Optional) block supports the following:
    allowed_headers [list(string)] - (Required) A list of headers that are allowed to be a part of the cross-origin request.
    allowed_methods [list(string)] - (Required) A list of http methods that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH.
    allowed_origins [list(string)] - (Required) A list of origin domains that will be allowed by CORS.
    exposed_headers [list(string)] - (Required) A list of response headers that are exposed to CORS clients.
    max_age_in_seconds [number] - (Required) The number of seconds the client should cache a preflight response.

  A retention_policy (Optional) block supports the following:
    days - (Optional) Specifies the number of days that the azurerm_storage_share should be retained, between 1 and 365 days. Defaults to 90

  A smb (Optional) block supports the following:
    versions [list(string)] - (Optional) A set of SMB protocol versions. Possible values are SMB2.1, SMB3.0, and SMB3.1.1.
    authentication_types [list(string)] - (Optional) A set of SMB authentication methods. Possible values are NTLMv2, and Kerberos.
    kerberos_ticket_encryption_type [list(string)] - (Optional) A set of Kerberos ticket encryption. Possible values are RC4-HMAC, and AES-256.
    channel_encryption_type [list(string)] - (Optional) A set of SMB channel encryption. Possible values are AES-128-CCM, AES-128-GCM, and AES-256-GCM.
  ```
  EOVS
}

variable "static_website" {
  type        = any
  default     = null
  description = <<EOVS
  A static_website (Optional) block
  ```

  type = object({
    index_document     = string
    error_404_document = string
  })

  index_document [string] - (Optional) The webpage that Azure Storage serves for requests to the root of a website or any subfolder. For example, index.html. The value is case-sensitive.
  error_404_document [string] - (Optional) The absolute path to a custom webpage that should be used when a request is made which does not correspond to an existing file.
  ```
  EOVS
}

variable "default_action" {
  description = "Specifies the default action of allow or deny when no other rules match."
  type        = string
  default     = "Deny"
}

variable "bypass" {
  description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None."
  default     = ["None"]
}

variable "ip_rules" {
  description = "List of public IP or IP ranges in CIDR Format. Only IPV4 addresses are allowed."
  default     = []
}

variable "virtual_network_subnet_ids" {
  description = " virtual network subnet ids attached to stg account"
  default     = []
}

variable "enable_privatelink" {
  description = "Variable to turn on Privatelink for the Module Resources."
  type        = bool
  default     = true
}

variable "enable_customer_managed_keys" {
  description = "Enable customer managed keys"
  type        = bool
  default     = true
}

variable "diagnostics" {
  description = "Diagnostic settings for those resources that support it. See README.md for details on configuration."
  type = object({
    destination   = string
    eventhub_name = string
    logs          = list(string)
    metrics       = list(string)
  })
  default = null
}

variable "containers" {
  type        = any
  default     = []
  description = <<EOVS
  List of containers to create and their access levels
  ```

  type = list(object({
    name                  = string
    container_access_type = string
    metadata              = map(string)
  }))

  name [string] - (Required) The name of the Container which should be created within the Storage Account
  container_access_type [string] - (Optional) The Access Level configured for this Container. Possible values are blob, container or private. Defaults to private
  metadata [map(string)] - (Optional) A mapping of MetaData for this Container. All metadata keys should be lowercase
  ```
  EOVS
}

variable "gen2fs" {
  type        = any
  default     = []
  description = <<EOVS
  Map to create a Data Lake Gen2 File System within an Azure Storage Account
  ```

  type = list(object({
    name       = string
    properties = map(string)
    owner      = string
    group      = string
    ace = list(object({
      type        = string
      permissions = string
      scope       = string
      id          = string
    }))
  }))

  name [string] - (Required) The name of the Data Lake Gen2 File System which should be created within the Storage Account. Must be unique within the storage account the queue is located. Changing this forces a new resource to be created
  properties [map(string)] - (Optional) A mapping of Key to Base64-Encoded Values which should be assigned to this Data Lake Gen2 File System.
  owner [string] - (Optional) Specifies the Object ID of the Azure Active Directory User to make the owning user of the root path (i.e. /). Possible values also include $superuser
  group [string] - (Optional) Specifies the Object ID of the Azure Active Directory Group to make the owning group of the root path (i.e. /). Possible values also include $superuser.
    NOTE:
    The Storage Account requires account_kind to be either StorageV2 or BlobStorage. In addition, is_hns_enabled has to be set to true

  An ace (Optional) block supports the following
    scope [string] - (Optional) Specifies whether the ACE represents an access entry or a default entry. Default value is access.
    type [string] - (Required) Specifies the type of entry. Can be user, group, mask or other.
    id [string] - (Optional) Specifies the Object ID of the Azure Active Directory User or Group that the entry relates to. Only valid for user or group entries.
    permissions [string] - (Required) Specifies the permissions for the entry in rwx form. For example, rwx gives full permissions but r-- only gives read permissions
  ```
  EOVS
}

variable "shares" {
  type        = any
  default     = []
  description = <<EOVS
  Map to create a File Share within Azure Storage.
  ```

  type = list(object({
    name             = string
    folders          = list(string)
    access_tier      = string
    enabled_protocol = string
    quota            = number
    metadata         = map(string)
    acl = list(object({
      id = string
      access_policy = list(object({
        start       = string
        expiry      = string
        permissions = string
      }))
    }))
  }))

  name [string] - (Required) The name of the share. Must be unique within the storage account where the share is located
  folders [list(string)] - (Required) The name of the File Share where this Directory should be created. Changing this forces a new resource to be created
  access_tier [string] - (Optional) The access tier of the File Share. Possible values are Hot, Cool and TransactionOptimized, Premium
  enabled_protocol [string] - (Optional) The protocol used for the share. Possible values are SMB and NFS. The SMB indicates the share can be accessed by SMBv3.0, SMBv2.1 and REST. The NFS indicates the share can be accessed by NFSv4.1. Defaults to SMB. Changing this forces a new resource to be created.
    NOTE:
    The Premium SKU of the azurerm_storage_account is required for the NFS protocol.
  quota [number] -  (Required) The maximum size of the share, in gigabytes. For Standard storage accounts, this must be 1GB (or higher) and at most 5120 GB (5 TB). For Premium FileStorage storage accounts, this must be greater than 100 GB and at most 102400 GB (100 TB)
  metadata [map(string)] - (Optional) A mapping of MetaData which should be assigned to this Storage shares.

  A acl (Optional) block supports the following:
    id [string] - (Required) The ID which should be used for this Shared Identifier.
    An access_policy (Required) block as defined below.
      permissions [string] - (Required) The permissions which should be associated with this Shared Identifier. Possible value is combination of r (read), w (write), d (delete), and l (list).
        Note:
        Permission order is strict at the service side, and permissions need to be listed in the order above.
      start [string] - (Optional) The time at which this Access Policy should be valid from, in ISO8601 format.
      expiry [string] - (Optional) The time at which this Access Policy should be valid until, in ISO8601 format.
  ```
  EOVS
}

variable "tables" {
  type        = any
  default     = []
  description = <<EOVS
  Map to create a Table within an Azure Storage Account.
  ```

  type = list(object({
    name = string
    acl = list(object({
      id = string
      access_policy = list(object({
        start       = string
        expiry      = string
        permissions = string
      }))
    }))
    partition_key = string
    row_key       = string
    entity        = map(string)
  }))


  name [string] - (Required) The name of the storage table. Must be unique within the storage account the table is located

  A acl (Optional) block supports the following:
    id [string] - (Required) The ID which should be used for this Shared Identifier.
    A access_policy (Required) block supports the following:
      start [string] - (Required) The ISO8061 UTC time at which this Access Policy should be valid from
      expiry [string] - (Required) The ISO8061 UTC time at which this Access Policy should be valid until
      permissions [string] - (Required) The permissions which should associated with this Shared Identifier

  partition_key [string] - (Required) The key for the partition where the entity will be inserted/merged. Changing this forces a new resource
  row_key [string] - (Required) The key for the row where the entity will be inserted/merged. Changing this forces a new resource.
  entity [map(string)] - (Required) A map of key/value pairs that describe the entity to be inserted/merged in to the storage table
  ```
  EOVS
}

variable "queues" {
  type        = any
  default     = []
  description = <<EOVS
  Map to create a Queue within an Azure Storage Account.
  ```

  type = list(object({
    name     = string
    metadata = map(string)
  }))

  name [string] - (Required) The name of the storage queues. Must be unique within the storage account the table is located
  metadata [map(string)] - (Optional) A mapping of MetaData which should be assigned to this Storage Queue.
  ```
  EOVS
}

variable "events" {
  description = "List of event subscriptions. See documentation for format description."
  type        = any
  default     = []
}

variable "vault_principal_id" {
  description = "The principal id for the vault.azure.net global spn"
  default     = "540f8220-7b42-4b86-b08b-d13146b3a8ec"
}

variable "vault_type" {
  description = "Which Vault type will this resource store its secrets. hashicorp, akv, or none"
  type        = string
  default     = "akv"
  validation {
    condition = (
      var.vault_type == "hashicorp" || var.vault_type == "akv" || var.vault_type == "none"
    )
    error_message = "A valid Vault type has not been declared."
  }
}

variable "key_vault_id" {
  description = "The ID of the custom Key Vault where the Secret should be created."
  type        = string
  default     = null
}


variable "blob_types" {
  description = "An array of predefined values. Valid options are blockBlob and appendBlob"
  type        = list(string)
  default     = ["blockBlob", "appendBlob"]
  validation {
    condition     = length(var.blob_types) < 3 && can([for s in var.blob_types : regex("blockBlob|appendBlob", s)])
    error_message = "A valid Storage type has not been declared."
  }
}

variable "is_BootDiag" {
  description = "Variable to set replication type to RAGRS when using for BootDiag storage"
  type        = bool
  default     = false
}

variable "enable_encryption" {
  description = "Enable encryption with platform managed key"
  type        = bool
  default     = false
}

variable "log_analytics_workspace_id" {
  description = "Id for log_analytics_workspace. Used to specify the destination for 'audit' logs. If not provided, a default log analytics workspace is choosen as the destination."
  type        = string
  default     = null
}

variable "purge_protection_kv" {
  description = "Disable purge protection for key vault"
  type        = bool
  default     = true
}
variable "disable_private_endpoint_kv" {
  description = "Disable private endpoint for resource type - key vault"
  type        = bool
  default     = false
}

variable "force_create_private_endpoint_containers" {
  description = "Create private endpoint for resource type - containers"
  type        = bool
  default     = false
}

variable "force_create_private_endpoint_tables" {
  description = "Create private endpoint for resource type - tables"
  type        = bool
  default     = false
}

variable "force_create_private_endpoint_queues" {
  description = "Create private endpoint for resource type - queues"
  type        = bool
  default     = false
}

variable "force_create_private_endpoint_shares" {
  description = "Create private endpoint for resource type - shares"
  type        = bool
  default     = false
}

variable "force_create_private_endpoint_gen2fs" {
  description = "Create private endpoint for resource type - gen2fs"
  type        = bool
  default     = false
}

variable "force_create_private_endpoint_index_document" {
  description = "Create private endpoint for resource type - index document"
  type        = bool
  default     = false
}

variable "enable_audit_diagnostics" {
  description = "Enable audit diagnostic settings"
  type        = bool
  default     = true
}
