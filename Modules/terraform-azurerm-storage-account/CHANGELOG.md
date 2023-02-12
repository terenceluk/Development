# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [7.0.3] - 2023-01-11

### Added

- added input variables:
  - `enable_audit_diagnostics` Enable audit diagnostic settings

## [7.0.2] - 2022-11-08

### Added

- Added optional network_rules block if nfsv3 enabled blobs as work around due to [error response](https://github.com/hashicorp/terraform-provider-azurerm/issues/14540) from Azure indicating ```Default network ACL using NFS must be set to deny```
  - network_rules added to azurerm_storage_account resource only if nfsv3_enabled feature set to true

## [7.0.1] - 2022-10-07

### Updated

- downgrade azureRm provider version to 3.9.0 to avoid bug <https://github.com/hashicorp/terraform-provider-azurerm/issues/17206>;

## [7.0.0] - 2022-07-22

### Updated

- the version of azurerm provider `>= 3.11.0`
- the version of HC Vault module to `1.1.2`
- the `variables.tf` file:
  `static_website`
  `share_properties`
  `queue_properties`
  `routing`
  `azure_files_authentication`
  `identity`
  `custom_domain`
  `blob_properties`
  `table_encryption_key_type`
  `queue_encryption_key_type`
  `large_file_share_enabled`
  `nfsv3_enabled`
  `edge_zone`
  `cross_tenant_replication_enabled`

### Added

- all suported blocks and parameters for the `azurerm_storage_account` resource (as of 3.11.0)

### Deleted

- variables for the `variables.tf` file:
  `index_document`
  `error_404_document`
  `delete_retention_days`
  `blob_cors_rule`
  `identity_type`
  `identity_ids`
  `container_delete_retention_days`

## [6.0.0] - 2022-05-06

### Updated

- Updating the version for the compatibility of the updated Azurerm version

## [5.4.8] - 2022-05-06

### Updated

- Updated azurerm version to (">= 3.0.2")
- Added allow_nested_items_to_be_public varable compitable with the version
- Added .terraform.lock.hcl in gitignore file
- Updated keyvault module to current version "3.3.7"
- Updated quota in azure storgae share

## [5.4.7] - 2022-04-07

### Added

- Added infrastructure_encryption_enabled

### Updated

- Set minimun azurerm provider version to >= 2.92.0

## [5.4.6] - 2022-04-05

### Updated

- Customize names of secrets for akv

## [5.4.5] - 2022-04-01

### Added

- Added support AKV integration

## [5.4.4] - 2022-03-15

### Updated

- Add sleep timer for containers to resolve issues with `10.255.255.253:53: no such host`.

## [5.4.3] - 2022-03-14

### Updated

- Updated "vault_mount_secrets" module to v1.1.1 in order to support "hashicorp/vault" provider condition ">= 2.17.0".

## [5.4.2] - 2022-02-22

### Updated

- Updated service documentation file to align service documentation to the revised template format
- Updated service documentation with correct grammar and spelling errors

## [5.4.1] - 2022-02-17

### Updated

- Updated blob properties from dynamic to static block in main.tf file
- Added a condition to versioining_enabled in main.tf file

## [5.4.0] - 2022-02-16

### Updated

- Updated azurerm provider version (">= 2.81.0")

### Added

- Added suport for the delivery_property block to module

## [5.3.5] - 2022-02-01

### Updated

- Updated the container_deleted_retention_days variable to 7 days as default.
- Updated the is_hns_enabled variable type from string to bool and removed quotation ("") marks from the default setting false as required to enable the soft delete for containers feature

## [5.3.4] - 2022-01-31

### Updated

- Update variables "force_create_private_endpoint_<type>" from string to bool as required by the pivate link code logic.

## [5.3.3] - 2022-01-21

### Updated

- Updated container_delete_retention_days in the variables.yaml file to match respective resource block in main.tf file
- Updated values to match respective data types in private_link.tf file under pe_list section

## [5.3.2] - 2022-01-18

### Updated

- Corrected VERSION for retagging in Terraform Enterprise

## [5.3.1] - 2022-01-14

### Updated

- Added support for delete_retention_policy and container_delete_retention_policy to module

## [5.3.0] - 2022-01-10

### Updated

Updated module capabilities to support managed identity;
Updated azurerm provider version.

## [5.2.0] - 2021-12-21

### Updated

Added ability to provide custom log analytics workspace for audit logs;
Add force_create_private_endpoint_* parameters

## [5.1.8] - 2021-12-03

### Updated

Updated module capabilities to create Private Endpoint for a static website

## [5.1.7] - 2021-12-01

### Updated

Added Map generation for management policy Rule instead of "management policy" resource.
It prevents rewrite rules during creation (all policies has suffix "managementPolicies/default").

## [5.1.6] - 2021-10-06

### Updated

Added microsoft managed encryption scope to storage

## [5.1.5] - 2021-10-04

### Updated

Updated to generate subnet_id without using data resource
Updated KeyVault module version

## [5.1.4] - 2021-09-07

### Updated

Updated to support app02 subnet

## [5.1.3] - 2021-08-20

### Updated

Updated resource group name for GEN2

## [5.1.2] - 2021-08-10

### Updated

Refactor tags support

## [5.1.1] - 2021-08-09

### Fixed

Storage Replication override for Prod Boot Diagnostic Storage using is_BootDiag

## [5.1.0] - 2021-06-21

### Added

- Added Storage Management Policies for base_blob block:
  - tier_to_cool_after_days
  - tier_to_archive_after_days

## [5.0.4] - 2021-06-21

### Fixed

Tags not properly being ignored

## [5.0.4] - 2021-06-21

### Changed

Replaced hard code with blob_types variable and added support for appendBlob storage type

## [5.0.3] - 2021-06-17

### Changed

Added option for blob public access

## [5.0.2] - 2021-06-07

### Fixed

PE only created if they have the matching resource

### Updated

Service documentation updated to reflect current state

## [5.0.1] - 2021-05-31

### Fixed

Incorrect variable type for event grid "events" variable cause it only to accept 1 map in the list  

## [5.0.0] - 2021-05-10

### Breaking Change

Naming convention uses random sequence to make storage accounts smaller and more random.

### Added

Support for EventGrid events registered to multiple different endpoints
Purge protection for regular blobs
Versioning & Cors for blobs
Support for storage lifecycles
Ability to choose either akv, hashicorp or none for your secret storage

### Enchancements

Cleaned up private endpoint and dns code to reduce its overall size
Proper diagnostics for storage accounts
Consistent features naming convention - disabled_keys became enable_customer_managed_keys

## [4.9.0] - 2021-04-22

### Changed

Fixed the logic for the virtual subnet ids, and added inputs to attach subnets

## [4.8.0] - 2021-01-18

### Added

- Defaults nonprod and prod private endpoints to corenetwork app01 when they are set to null but private endpoints enabled

### Changed

- Bumping vault module to 2.5.0 to remove depreciated settings warnings cause by azure soft delete change
- removed count with for_each when possible

## [4.7.0] - 2021-01-11

### Added

Added Queues functionality,linking event grid subscription

## [4.6.0] - 2021-01-01

### Changed

- Storage account name with "st" suffix

## [4.5.0] - 2020-12-13

### Added

- Added gen2_path configuration, set tls version to 1.2 and enable https configuration.

## [4.4.4] - 2020-11-10

### Fixed

- Removing KitchenCI hardcoded version, adding output primary_blob_endpoint

## [4.4.3] - 2020-10-15

### Fixed

- private link creating when disabled

## [4.4.2] - 2020-10-15

### Fixed

- added a sleep to the cli script to avoid being run before the vault is ready

### [4.4.1] - 2020-10-15

### Fixed

- unable to set bypass for AzureServices
- missing tags options

### [4.4.0] - 2020-10-15

### Added

- add ability to override default storage account name with var.name_override
- add ability to bypass customer managed keys if by setting disable_keys = true

### [4.3.2] - 2020-10-13

### Fixed

- change login values for az_keys.sh when using tfe

### [4.3.1] - 2020-10-13

### Fixed

- wrong tenant variable in az login script

### [4.3.0] - 2020-10-10

### Added

- keyvault gets created with storage account
- adding support for customer managed keys as well as rotated access keys

### [4.2.0] - 2020-10-05

### Added

- Adding option to turn on or off outputs (keys, secrets) to hashicorp vault. Added ignore tags for private link. Added new outputs.

### [4.1.0] - 2020-10-01

### Added

- Adding vault mount-secret to save outputs to vault, removed connection_string from outputs and updated README.md

### [4.0.2] - 2020-09-30

### Fixed

- Fixing conditional for Private Link. It was creating the resources even with empty maps. Fixed README.md

### [4.0.1] - 2020-09-29

### Fixed

- index_document and error_404_document needs to be null if not passed in the map

### [4.0.0] - 2020-09-24

### Changed

- Refactored module to work in full with TF 0.13. This is a major change and should be used only when deploying new storage accounts or rebuilding old ones.
- Added Tables and Tables Identity to Storage Account Module

### [3.0.0] - 2020-09-15

### Changed

- Bumped Terraform Version to 0.13

### [2.5.0] - 2020-08-20

### Changed

- added static website block to the storage module

### [2.4.0] - 2020-04-28

### Changed

- updated storage module to get inflobox credentials from hashivault

### [2.3.4] - 2020-04-15

### Fixed

- Cleaned up test cases and plans

### [2.3.3] - 2020-04-15

### Fixed

- removed test cases for container creation, gen2 file storage

### [2.3.2] - 2020-04-14

### Fixed

- fixed the default action of network rules to deny

### [2.3.1] - 2020-04-13

### Fixed

- fixed hns variable setting so its not always set to true

### [2.3.0] - 2020-04-12

### Fixed

- DNS provisioner now uses triggers

### Added

- DataLake to privateLink DNS

### Changed

- if gen2fs is not null hns is enabled by default

### [2.2.6] - 2020-04-05

### Removed

- Removed the SAS token and key vault creation

### [2.2.5] - 2020-03-19

### Added

- Adding Key vault secret resource, it will save sas tokens into secrets key vault.

### [2.2.4] - 2020-03-17

### Added

- Test cases, added SAS token capability and instance number

### [2.2.3] - 2020-03-05

### Added

- Gen2 file system (hierarchical namespace) available for Data Lake

### [2.2.2] - 2020-03-02

### Fixed

- add depends on to the data pull

### [2.2.1] - 2020-03-02

### Fixed

- missing depends on attempts to create DNS before an ip is assigned

### [2.2.0] - 2020-02-28

### Added

- private link is now enabled on the resoures defined plan. Currently supports blob,tables,file,queue

### [2.1.0] - 2020-02-25

### Fixed

- Container and Share naming convention missconfigured

### [2.0.0] - 2020-02-08

### Changed

- module uses for_each for all calls containers and shares are lists

### [0.1.0] - 2020-01-21

### Added

- Initial implementation
