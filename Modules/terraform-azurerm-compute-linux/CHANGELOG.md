# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [2.0.0]

### Updated

- Updated azurerm version to >= 3.0.0
- Updated `storage account module` version to 7.0.1
- Use string for `azure_managed_disk` zone

## [1.1.3]

### Updated

- Updated the `storage-account module` version to `5.4.7`

## [1.1.2]

### Updated

- `var.aad_authentication` is removed as not needed
- dependency on Azure AD admin/user group for `AADSSHLoginForLinux` VM extension installation is added

## [1.1.1]

### Updated

- VM lifecycle `ignore_changes` is changed to `tags`

## [1.1.0]

## Updated

- Added linux vm backup service
- Added Azure AD auth
- Added Disaster recovery
- Updated service docs
- Updated tests
- Fixed variables

## [1.0.4]

## Updated

- Add UAMI to chose between UserAssigned or SystemAssigned Identity

## [1.0.3]

### Fixed

- Add Akv integration

## [1.0.2]

### Fixed

- Add location to boot diagnostic storage

## [1.0.1]

### Updated

- Incremented vault secret module version
- Incremented storage account module version

## [1.0.0]

### Updated

- Added resource "tls_private_key" to generate ssh key automatically.
- Added private key to store in vault mount secret.
- VM naming convention updated.

## [0.1.2]

### Updated

- Updated source image id and source image reference arguments.

## [0.1.1]

### Added

- Added shared image id variable to source image id. This will allow a user to mention direct path of image id.

## [0.1.0]

### Added

- Initial release
- Service catalog documentation and diagram
