# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [4.1.1] - 2022-09-21

### Added

- Added `vault_certificate_generate_versionless_secret` output

## [4.1.0] - 2022-08-09

### Added

- Added `azurerm_key_vault_key` resource

## [4.0.0] - 2022-08-11

### Updated

- Updated azurerm provider to version 3.3.0

### Added

- Added generation variable
- Added soft_delete_retention_days parameter for azurerm_key_vault
- Added contact block for azurerm_key_vault
- Added condition and condition_version parameters for azurerm_role_assignment
- Added delegated_managed_identity_resource_id parameter for azurerm_role_assignment
- Added description parameter for azurerm_role_assignment
- Added skip_service_principal_aad_check parameter for azurerm_role_assignment
- Added application_id parameter for azurerm_key_vault_access_policy

## [3.3.9] - 2022-08-10

### Updated

- Updated access_mixed_mode variable to use both rbac and access policy

## [3.3.8] - 2022-04-04

### Added

- Added input variable `enable_audit_diagnostics`
- Removed metric block for audit azure diagnostic setting

## [3.3.7] - 2022-03-21

### Updated

- Fixed a bug in the  `not_before_date` values assignment

## [3.3.6] - 2022-03-21

### Updated

- Changed lettercase for `secret_permissions` values

## [3.3.5] - 2022-03-21

### Updated

- add expitation_date and not_before_date attributes to the secrets definition

## [3.3.4] - 2022-02-24

### Updated

- Service documentation formatting

## [3.3.3] - 2021-12-23

### Updated

- Added ability to provide custom log analytics workspace for audit logs

## [3.3.2] - 2021-10-22

### Updated

- Updated readme with gen2 provisioning details

## [3.3.1] - 2021-10-04

### Updated

- Updated to generate subnet_id without using data resource.

## [3.3.0] - 2021-09-21

### Added

- Added Custom Diagnostic settings

## [3.2.0] - 2021-09-17

### Added

- Added ability to add secrets in Azure KeyVault.

## [3.1.0] - 2021-06-22

### Added

- Added ability to overide the default mapped object_id variable to enable gen2 deployments
- Removed hardcoded subnet

## [3.0.1] - 2021-06-22

### Updated

- Updated version hashicorp/azurerm

## [3.0.1] - 2021-05-09

### Fixed

- Mixed case permissions causing change lookup in access policy rules

## [3.0.0] - 2021-04-26

### Added

- Support for Azure RBAC, setting enable\_rbac\_authorization to true will
disable access policies and use RBAC

## [2.5.0] - 2020-01-16

### Added

- private network now defaults to app01 subnet in the current enviroment if
 private link is enabled but network info not set

### Removed

- `soft_delete_enabled` removed as its now mandatory enforced as enabled by
 azure for any new keyvaults.

### Changed

- changed the count references to for_each to avoid conflicts with count module
 not knowing how to calculate the value without applying first

## [2.4.0] - 2020-01-07

### Added

- Added key_vault_certificate_issuer resource code

## [2.3.4] - 2020-01-04

### Changed

- removed hardcoded filebase64 on importing certificate contents

## [2.3.3] - 2020-12-22

### Changed

- default terraform access policy to add purge for cleanup task

## [2.3.2] - 2020-12-21

### Changed

- Generate Certificate naming for multiple instances

### Fixed

- Corrected generate_certificates and map variables; and import_certificates
 and map variables

## [2.3.1] - 2020-12-15

### Changed

- Added instance count to keyvault name format

## [2.3.0] 2020-12-14

### Added

- Adding support for importing and creating of certificate using azurerm_key_vault_certificate

### Issue

- There is no inspec resource for validating the certificates are uploaded in
 azure key vault. I created the feature request in github (<https://github.com/inspec/inspec-azure/issues/353>).

## [2.2.2] 2020-10-14

### Fixed

- private endpoint disabled but the subnet variables are still required

## [2.2.1] 2020-10-13

### Fixed

- fix private endpoint naming convention to match other pe

## [2.2.0]

### Added

- custom_policy variable can now be set to create custom policy on the vault
- adding the vault name as a possible output value
- you can now override the default naming convention for your vault by setting var.name_override

## [2.1.1]

### Added

- Add CHANGELOG.md

## [2.1.0]

### Added

- Add disable_private_endpoint variable.

## [2.0.1] - 2020-09-30

### Added

- We need Azure Key Vault Diagram inside docs folder to link to confluence.

## [2.0.0] - 2020-09-29

### Changed

- Refactored module to work in full with TF 0.13. This is a major change and
 should be used only when deploying new azure key vaults or rebuilding old ones.

## [1.1.1]

### Fixed

- If using the newer version of az provider 2.9 it is a new feature and we need
 to include tags on lifecycle ignore for azurerm_private_endpoint

## [1.1.0]

### Changed

- Removing unused variables and updating README with more detailed how to

## [1.0.0]

### Added

- Capability to deploy multiple keyvault's on demand

## [0.2.4]

### Changed

- Adding condition, if `env == sandbox`, `soft delete` and
 `purge_protection_enabled` should be default as `false` else `true`.
  Also we have the ability to override to true or false.

## [0.2.3]

### Changed

- Removing commented lines on `soft_delete_enabled` and `purge_protection_enabled`.
 We don't need to make this module compatible with provider 1.44 anymore.

## [0.2.2]

### Changed

- Bumping provider version to accept to call resource and get private_ip_address

## [0.2.1]

### Changed

- Adding trigger to null resource, it will be called only when changing vault name,
 infoblox_creds or ip. Making the module compatible with TF 0.13

## [0.2.0]

### Changed

- Adding map containing all default object_id's from vault groups. It will make
 our module flexible and based on the environment.

## [0.1.1]

### Changed

- Making this module compatible with AzureRM Provider Version 1.44,
 Commenting: soft_delete_enabled and purge_protection_enabled. These options are
  already false as default.
- Adding Terraform Admin Policy as static and default.

## [0.1.0]

### Added

- Initial implementation of key vault azure
