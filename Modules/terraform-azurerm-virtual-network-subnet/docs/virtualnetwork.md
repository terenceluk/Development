<!-- markdown-link-check-disable -->
### Service Owner - Cloud Operations & Automation  
Service Version - 1.0

**Prerequisite**: Base provisioning completed

**Current Offering**: We currently offer private Networking inside of Azure over VPN

**Intake Processes**
Do you require a dedicated subnet?
Do you require only an IP inside an existing subnet?
Which subnet? app/db/web

- Do we need an intake process given that this is not going to be a directly requested service?

***Current spec***
- https://bitbucket.corp.ad.ctc/projects/TFEWS/repos/eis-az-corenetwork/browse

**Overview**
The virtual network is a supporting service of other resources that require private network connectivity

**Architectural Overview**
<The diagram would need to include CTC DNS name, access path, key storage location, subscription> 

**Detail Design**
- Hub and spoke module with infra being the hub and all others being the spokes
- VPN connection terminates in the Hub subscription and provides access through a VPN gateway
- Each subscription consists of a main VNET and its required subnets
- PAN filters all traffic entering azure from onprem data centers through UDR routes pointing to the applicances in the INFRA subscription
- IP ranges inside Azure and existing onprem network must be unique
- A corresponding network architecture is created in Canada East to support future DR requirements

**Security Architecture**
- PANs monitor and enforce all IaaS traffic coming in and out of azure
- PANs inspect traffic that between virtual networks (ie. hub <-> spoke , spoke <-> spoke traffic)
- Within each virtual network, NSGs are configured at the subnet level to restrict subnet to subnet traffic

**How to use the service?**
- This service is not typically consumed on its own but is a supporting service of another. An example would be to provide connectivity to a virtual machine it would require a virtual network service

**Support processes**
- Local Network Gateway for each VPN tunnel https://bitbucket.corp.ad.ctc/projects/EFTM/repos/terraform-azurerm-virtual-network-vpn/browse/README.md
- 2 Public IPs for the VPN Gateway https://bitbucket.corp.ad.ctc/projects/EFTM/repos/terraform-azurerm-virtual-network-vpn/browse/README.md
- VPN Gateway https://bitbucket.corp.ad.ctc/projects/EFTM/repos/terraform-azurerm-virtual-network-vpn/browse/README.md
- Virtual Network https://bitbucket.corp.ad.ctc/projects/EFTM/repos/terraform-azurerm-virtual-network/browse/README.md
- Creating Subnets https://bitbucket.corp.ad.ctc/projects/EFTM/repos/terraform-azurerm-virtual-network-subnet/browse/README.md
- Creating User defined routes https://bitbucket.corp.ad.ctc/projects/EFTM/repos/terraform-azurerm-virtual-network-route/browse/README.md


**Troubleshooting**
- Lost access due to network
  - Review access logs & perform a Trace route

**Incident Alerting/Escalation Processes** 

| Metric/Events                         | Target                  | Response Process    | Threshold |
|---------------------------------------|-------------------------|---------------------|-----------|

**Backup and Availability**

**Disaster Recovery**
- The virtual network configuration has been created in Canada East and Canada Central Azure regions so support future DR requirements

**Maintenance and Patching**
-N\A

**Access Management**
- Access for virtual network administration is restricted to the COA team
- terraform enteprise enabled repo 

**Provisioning**
- <Show IaC / TFE provisionining process>

**To Do**
- complete PAN setup in Canada East for full redundancy

**References**

https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/hybrid-networking/hub-spoke

https://docs.microsoft.com/en-us/archive/blogs/canitpro/step-by-step-configuring-a-site-to-site-vpn-gateway-between-azure-and-on-premise

<!-- markdown-link-check-disable -->