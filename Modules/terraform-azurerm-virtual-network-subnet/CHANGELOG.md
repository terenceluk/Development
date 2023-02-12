# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [3.0.1] - 2022-11-17

### Updated

- revert "-Added name_extension_override to append the extension to the override_subnet_name value

## [3.0.0] - 2022-11-02

### Updated

- replace/rename enforce_private_link_service_network_policies parameter which was replaced with private_link_service_network_policies_enabled
- replace/rename enforce_private_link_endpoint_network_policies  parameter which was replaced with private_endpoint_network_policies_enabled
as of 3.18.0 [issue](https://github.com/hashicorp/terraform-provider-azurerm/pull/17464) [changelog](https://github.com/hashicorp/terraform-provider-azurerm/blob/3ebfd04f4be9e77f5c5331f7e7b27d9cc59acd64/CHANGELOG.md#3180-august-11-2022)

## [2.3.0] - 2022-08-05

### Updated

- Preparation for migration to the AzureRm provider => 3.0.0

## [2.2.0] - 2020-11-02

### Added

- Added check to  nsg and route table association code to use default null when no value pass

## [2.1.0] - 2020-11-01

### Added

- Convert nsg and route_table variable from map of any to map of objects

## [2.0.0] - 2020-09-24

### Added

- Convert the module to support Terraform 0.13

## [1.3.2] - 2020-06-12

### Added

- added lifecycle to ignore nsg id changes, and also address prefix changes

## [1.3.1] - 2020-06-01

### Added

- added lifecycle to ignore rt id changes

## [1.3.0] - 2020-04-23

### Added

- added support for azurerm 2.2+
- the ability to use delegation blocks

## [1.2.0] - 2020-01-29

### Added

- ability to add nsg and route tables to subnets

## [1.1.1] - 2020-01-20

### Added

- Ignoring changes in route_table_id attribute to prevent dependency between azurerm_subnet and azurerm_subnet_route_table_association as describe [here: "https://www.terraform.io/docs/providers/azurerm/r/subnet_route_table_association.html"]. Same for network_security_group_id.

## [1.1.0] - 2020-01-02

### Added

- added support to name the subnet something other then the key name to avoid conflict with similar named subnets

## [1.0.1] - 2020-01-02

### Fixed

- Changed variable type to "any" which allows the mixed string and lists in a map

## [1.0.0] - 2019-12-31

### Changed

- Only allowed variable is a map which allows you to specify multiple subnets at time using a for_each statement

## [0.1.1] - 2019-12-27

### Fixed

- subnet name should include vnet name not resource group name according to naming standards

## [0.1.0] - 2019-12-27

### Added

- Initial implementation supporting resource group, virtual network, and an optional number of subnets
