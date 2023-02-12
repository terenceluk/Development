# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [4.0.1] - 2020-04-06
### Fixed
- availability set created even if no vms being provisioned

## [4.0.0] - 2020-03-31
### Added
- infoblox for privatelink of blob storage

### Changed
- bootdiag storage account now creates privatelink by default
- compute module now supports terraform azurerm 2.3+

## [3.1.0] - 2020-03-17
### Added
- add ability to attach an existing backup policy to the vm

## [3.0.0]
### Changed
- Create availability set on its own for the whole resource group can use it. Set the disable_availability_set if the vm is not required to be in it
- Project_name, Enviroment, Location Code need to be defined so the availability set is properly named
- lifecycle on vm set to ignore all changes

## [2.3.1]
### Fixed
- missing lifecycle ignore on image id

## [2.3.0]
### Changed
- `admin_password` when not set is randomly generated and captured in sensitive output
- gallery image is reference by ID when publisher variable is not set
- boot_diag creates its own storage account per vm as to avoid conflicts when only 1 boot diag per storage account
- Static IP can be assigned but if its not will defaut to Dynamic

## [2.2.0]
### Changed
- `admin_password` it's now required. You need to set variable admin_password as sensitive.

## [2.1.0]
### Changed
- Grab from shared gallery instead of going to an image directly
### Added
- Diag storage container created if storageaccount defined

## [2.0.0] - 2020-01-07
### Added
- Initial implementation using CTC custom specifics
