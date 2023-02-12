# Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.43.0 |

## Providers

| Name | Version
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 2.43.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.custom_policies](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.terraform_default_policies](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_certificate.generating](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate) | resource |
| [azurerm_key_vault_certificate.importing](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate) | resource |
| [azurerm_key_vault_certificate_issuer.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_certificate_issuer) | resource |
| [azurerm_private_endpoint.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_role_assignment.rbac_keyvault_admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [null_resource.main](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_brand"></a> [brand](#input\_brand) | Default brand name | `string` | `"ctc"` | no |
| diagnostics | Diagnostic settings for those resources that support it. See README.md for details on configuration. | <pre>object({<br>    destination   = string<br>    eventhub_name = string<br>    logs          = list(string)<br>    metrics       = list(string)<br>  })</pre> | `null` | no |
| <a name="input_enable_audit_diagnostics"></a> [enable\_audit\_diagnostics](#input\_enable\_audit\_diagnostics) | Enable audit diagnostic settings. | `bool` | `"true"` | no |
| <a name="input_bypass"></a> [bypass](#input\_bypass) | Specifies which traffic can bypass the network rules. Possible values are AzureServices and None. | `string` | `"None"` | no |
| <a name="input_certificate_issuer"></a> [certificate\_issuer](#input\_certificate\_issuer) | This block will manages a Key Vault Certificate Issuer.<br>`key_vault_id` - (Required) The ID of the Key Vault in which to create the Certificate Issuer.<br>`name` - (Required) The name which should be used for this Key Vault Certificate Issuer. Changing this forces a new Key Vault Certificate Issuer to be created.<br>`provider_name` - (Required) The name of the third-part
Certificate Issuer. Possible values are: DigiCert, GlobalSign, OneCertV2-PrivateCA, OneCertV2-PublicCA and SslAdminV2.<br>`org_id` - (Optional) The ID of the organization as provided to the issuer.<br>`account_id` - (Optional) The account number with the third-party Certificate Issuer.<br>`admin` - (Optional) One or more admin blocks as defined below.<br>`password` - (Optional) The password associated with the account and organization ID at the third-party Certificate Issuer. If not specified, will not overwrite any previous value. | `list(any)` | `[]` | no |
| <a name="input_certificate_issuer_admin"></a> [certificate\_issuer\_admin](#input\_certificate\_issuer\_admin) | This block will create list of admin blocks.<pre>`email_address` - E-mail address of the admin.<br>`first_name` - First name of the admin.<br>`last_name` - Last name of the admin.<br>`phone` - Phone number of the admin.</pre> | `map(any)` | `{}` | no |
| <a name="input_custom_policy"></a> [custom\_policy](#input\_custom\_policy) | A list containing a map of custom policy rules, all permissions need to be defined even if not being used | <pre>list(object({<br>    policy_name
  = string<br>    object_id               = string<br>    certificate_permissions = list(string)<br>    key_permissions         = list(string)<br>    secret_permissions      = list(string)<br>    storage_permissions     = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_default_action"></a> [default\_action](#input\_default\_action) | The Default Action to use when no rules match from ip\_rules / virtual\_network\_subnet\_ids. | `string` | `"Deny"` | no |
| <a name="input_disable_private_endpoint"></a> [disable\_private\_endpoint](#input\_disable\_private\_endpoint) | Disable private endpoint integration for specific use cases. | `string` | `false` | no |
| <a name="input_enable_rbac_authorization"></a> [enable\_rbac\_authorization](#input\_enable\_rbac\_authorization) | Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. | `bool` | `true` | no |
| <a name="input_enabled_for_deployment"></a> [enabled\_for\_deployment](#input\_enabled\_for\_deployment) | Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. Defaults to false. | `string` | `false` | no |
| <a name="input_enabled_for_disk_encryption"></a> [enabled\_for\_disk\_encryption](#input\_enabled\_for\_disk\_encryption) | Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Defaults to false. | `string` | `false` | no |
| <a name="input_enabled_for_template_deployment"></a> [enabled\_for\_template\_deployment](#input\_enabled\_for\_template\_deployment) | Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. Defaults to false. | `string` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Which enviroment, sandbox, nonprod or prod for gen1 deployments. Gen2 deployments use unique env name. | `string` | n/a | yes |
| <a name="input_generate_certificates"></a> [generate\_certificates](#input\_generate\_certificates) | This block supports the following list(map(string)) to generate certificates<br>`certificate_name` - (Required) Specifies the name of the Key Vault Certificate.<br>`issuer_parameters` - (Required) The name of the Certificate Issuer. Possible values include Self (for self-signed certificate), or Unknown<br>`exportable` - (Required) Is this Certificate Exportable?<br>`key_size` - (Required) The size of the Key used in the Certificate. Possible values include 2048, 3072, and 4096<br>`key_type` - (Required) Specifies the Type of Key, such as RSA<br>`reuse_key` - (Required) Is the key reusable?<br>`action_type` - (Required) The Type of action to be performed when the lifetime trigger is triggerec. Possible values include AutoRenew and EmailContacts<br>`days_before_expiry` - (Optional) The number of days before the Certificate expires that the action associated with this Trigger should run. Conflicts with lifetime\_percentage<br>`lifetime_percentage` - (Optional) The percentage at which during the Certificates Lifetime the action associated with this Trigger should
run. Conflicts with days\_before\_expiry<br>`content_type` - (Required) The Content-Type of the Certificate, such as application/x-pkcs12 for a PFX or application/x-pem-file for a PEM<br>`extended_key_usage` - (Optional) A list of Extended/Enhanced Key Usages. <br>`key_usage` - (Required) A list of uses associated with this Key. Possible values include cRLSign, dataEncipherment, decipherOnly, digitalSignature, encipherOnly, keyAgreement, keyCertSign, keyEncipherment and nonRepudiation and are case-sensitive<br>`subject` - (Required) The Certificate's Subject<br>`validity_in_months` - (Required) The Certificates Validity Period in Months<br>`dns_names` - (Optional) A list of alternative DNS names (FQDNs) identified by the Certificate<br>`emails` - (Optional) A list of email addresses identified by this Certificate. <br>`upns` - (Optional) A list of User Principal Names identified by the Certificate | `list(any)` | `[]` | no |
| <a name="input_import_certificates"></a> [import\_certificates](#input\_import\_certificates) | This block supports the following list(map(string)) to generate certificates<br>`certificate_name` - (Required) Specifies the name of the
Key Vault Certificate.<br>`contents` - (Required) The base64-encoded certificate contents<br>`password` - (Optional) The password associated with the certificate<br>`issuer_parameters` - (Required) The name of the Certificate Issuer. Possible values include Self (for self-signed certificate), or Unknown<br>`exportable` - (Required) Is this Certificate Exportable?<br>`key_size` - (Required) The size of the Key used in the Certificate. Possible values include 2048, 3072, and 4096<br>`key_type` - (Required) Specifies the Type of Key, such as RSA<br>`reuse_key` -  (Required) Is the key reusable? <br>`content_type` - (Required) The Content-Type of the Certificate, such as application/x-pkcs12 for a PFX or application/x-pem-file for a PEM | `list(any)` | `[]` | no |
| <a name="input_instance_number"></a> [instance\_number](#input\_instance\_number) | instance number of azure keyvault | `string` | `"01"` | no |
| <a name="input_ip_rules"></a> [ip\_rules](#input\_ip\_rules) | One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault. | `list(any)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure location | `string` | `"Canada Central"` | no |
| <a name="input_location_code"></a> [location\_code](#input\_location\_code) | Your location code (cc or cc) | `string` | `"cc"` | no |
| <a name="input_name_override"></a> [name\_override](#input\_name\_override) | Setting this will override the default keyvault naming convention but will still append -kv to the end of the name | `string` | `null` | no |
| <a name="input_object_id"></a> [object\_id](#input\_object\_id) | The object ID of a AAD security group in the Azure Active Directory tenant for the vault. This variable is used for gen2 deployments to overide the default mapped values | `string` | `null` | no |
| <a name="input_application_id"></a> [application\_id](#input\_application\_id) | The object ID of an Application in Azure Active Directory. | `string` | `null` | no |

| <a name="input_role_assignment_condition"></a> [role\_assignment\_condition](#input\_role\_assignment\_condition) | The condition that limits the resources that the role can be assigned to. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_role_assignment_condition_version"></a> [role\_assignment\_condition\_version](#input\_role\_assignment\_condition\_version) | The version of the condition. Possible values are 1.0 or 2.0. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_delegated_managed_identity_resource_id"></a> [delegated\_managed\_identity\_resource\_id](#input\_delegated\_managed\_identity\_resource_id) | The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | The description for this Role Assignment. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_skip_service_principal_aad_check"></a> [skip\_service\_principal\_aad\_check](#input\_skip\_service\_principal\_aad\_check) |  If the principal_id is a newly provisioned Service Principal set this value to true to skip the Azure Active Directory check which may fail due to replication lag. This argument is only valid if the principal_id is a Service Principal identity. If it is not a Service Principal identity it will cause the role assignment to fail. | `bool` | `false` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name | `string` | n/a | yes |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | Is Purge Protection enabled for this Key Vault? Defaults to false. | `string` | `true` | no |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 (the default) days. | `number` | `90` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The Name of the SKU used for this Key Vault. | `string` | `"standard"` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | Specifies the name of the Subnet for Private Endpoint (ex. ctc-nonprod-corenetwork-cc-vnet-app02-snet) use subnet app02 because app01 is full | `string` | `null` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | Tenant id | `string` | `"bd6704ff-1437-477c-9ac9-c30d6f5133c5"` | no |
| <a name="input_virtual_network_subnet_ids"></a> [virtual\_network\_subnet\_ids](#input\_virtual\_network\_subnet\_ids) | One or more Subnet ID's which should be able to access this Key Vault. | `list(any)` | `[]` | no |
| <a name="input_contact"></a> [contact](#input\_contact) | (Optional) One or more contact block. | `map(any)` | `{}` | no |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Specifies the name of the Virtual Network this Subnet is located within for Private Endpoint | `string` | `null` | no |
| <a name="input_vnet_rg"></a> [vnet\_rg](#input\_vnet\_rg) | Specifies the name of the resource group the Virtual Network is located in for Private Endpoint | `string` | `null` | no |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | Id for log_analytics_workspace. Used to specify the destination for 'audit' logs. If not provided, a default log analytics workspace is choosen as the destination. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vault_certificate_generate_certificate_data"></a> [vault\_certificate\_generate\_certificate\_data](#output\_vault\_certificate\_generate\_certificate\_data) | The raw Key Vault Certificate data represented as a hexadecimal string. |
| <a name="output_vault_certificate_generate_id"></a> [vault\_certificate\_generate\_id](#output\_vault\_certificate\_generate\_id) | The Key Vault Certificate ID. |
| <a name="output_vault_certificate_generate_secret_id"></a> [vault\_certificate\_generate\_secret\_id](#output\_vault\_certificate\_generate\_secret\_id) | The ID of the associated Key Vault Secret. |
| <a name="output_vault_certificate_generate_versionless_secret"></a> [vault\_certificate\_generate\_versionless\_secret](#output\_vault\_certificate\_generate\_versionless\_secret) | The Key Vault Certificate Secret Idenitifer without version for generated certificate. |
| <a name="output_vault_certificate_import_versionless_secret"></a> [vault\_certificate\_import\_versionless\_secret](#output\_vault\_certificate\_import\_versionless\_secret) | The Key Vault Certificate Secret Idenitifer without version for imported certificate. |
| <a name="output_vault_certificate_generate_thumbprint"></a> [vault\_certificate\_generate\_thumbprint](#output\_vault\_certificate\_generate\_thumbprint) | The raw Key Vault Certificate data represented as a hexadecimal string. |
| <a name="output_vault_certificate_import_certificate_data"></a> [vault\_certificate\_import\_certificate\_data](#output\_vault\_certificate\_import\_certificate\_data) | The raw Key Vault Certificate data represented as a hexadecimal string. |
| <a name="output_vault_certificate_import_id"></a> [vault\_certificate\_import\_id](#output\_vault\_certificate\_import\_id) | The Key Vault Certificate ID. |
| <a name="output_vault_certificate_import_secret_id"></a> [vault\_certificate\_import\_secret\_id](#output\_vault\_certificate\_import\_secret\_id) | The ID of the associated Key Vault Secret. |
| <a name="output_vault_certificate_import_thumbprint"></a> [vault\_certificate\_import\_thumbprint](#output\_vault\_certificate\_import\_thumbprint) | The raw Key Vault Certificate data represented as a hexadecimal string. |
| <a name="output_vault_certificate_import_version"></a> [vault\_certificate\_import\_version](#output\_vault\_certificate\_import\_version) | The current version of the Key Vault Certificate. |
| <a name="output_vault_id"></a> [vault\_id](#output\_vault\_id) | The ID of the Key Vault. |
| <a name="output_vault_key_vault_certificate_issuer"></a> [vault\_key\_vault\_certificate\_issuer](#output\_vault\_key\_vault\_certificate\_issuer) | The ID of the Key Vault Certificate Issuer. |
| <a name="output_vault_uri"></a> [vault\_uri](#output\_vault\_uri) | The URI of the Key Vault, used for performing operations on keys and secrets. |
