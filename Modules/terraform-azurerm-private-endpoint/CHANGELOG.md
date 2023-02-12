# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2023-02-02

### Updated

- Fixed request message condition
- Updated test to try creating request message

## [1.0.0]

### Updated

- Add ability to skip private DNS record creation
- Additional tests
- Update azurerm version in tests
- Refactored module
- Minimum azurerm version to 3.36.0 for updated `ip_configuration` block support

### Added

- `dynamic "private_dns_zone_group` block and corresponding variables
- `dynamic "ip_configuration"` block and corresponding variables

## [0.1.0]

### Added

- Initial release
