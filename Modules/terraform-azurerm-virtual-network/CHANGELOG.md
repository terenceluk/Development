# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [v4.1.1] 2022-05-31
### Removed
- Remove metrics from audit diagnostics


##[v4.1.0] - 2021-12-10
### Added
- option to enable ddos protection on VNET

##[v4.0.2] - 2021-07-06
### Added
- clean up redundant variables

##[v4.0.1] - 2021-07-05
### Added
- Added custom diags and local vars

##[v4.0.0] - 2021-03-2
### Added
- Adding ID number to the Virtual Network name, it will help to create multiple Virtual Networks

##[v3.1.0] - 2020-11-16
### Updated 
- Update the Readme

##[v3.0.1] - 2020-09-21
### Added
- Added log analytics configuration

##[v3.0.0] - 2020-09-18
### Changed
- added support for terraform 0.13

##[v2.1.0] - 2021-12-16
### Added
- Enabling DDOS Protection Standard

##[v2.0.2] - 2020-04-27
### Fixed
- add ignore tags so that terraform and policy don't compete

##[v2.0.1] - 2020-01-04
### Fixed
- Outputs in list format are harder to parse with for_each change them to a map

## [2.0.0] - 2020-01-02
### Changed
- VNET creation is now a map so multiple vnets can be created at a time
- brand is a default variable set to "ctc"
### Added
- vnet_name can be used to identify the short name of the vnet or using the map key

## [1.0.1] - 2019-12-27
### Fixed
- Missing vnet name in naming convention

## [1.0.0] - 2019-12-27
### Removed
- Remove the subnet and peering to their own module

## [0.4.0] - 2019-12-24
### Add
- Add the subnet option "service_endpoints"
- Support for azurerm_virtual_network_peering

## [0.3.0] - 2019-12-19
### Changed
- Add terraform 12.x support
- lowercase resource name
### Added
- standard tags to ensure proper tagging

## [0.2.0] - 2019-07-16
### Added
- Support optional override variable (`vnet_name_override`) for virtual network name, for corner cases like infrastructure (hub) networks
- Support optional customization variable (`resource_group_descriptor`) of resource group descriptor (default is "CoreNetwork")
- Output virtual network name (`vnet_name`) to support external creation of virtual network peerings
- Output virtual network id (`vnet_id`) to support external creation of virtual network peerings
- Output resource group name (`rg_name`) to support external creation of gateway connections and peerings

## [0.1.0] - 2019-07-12
### Added
- Initial implementation supporting resource group, virtual network, and an optional number of subnets
