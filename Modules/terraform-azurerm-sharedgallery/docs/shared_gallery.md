### Service Owner - Cloud Operations & Automation  
Service Version - 1.0

**Prerequisite**: Base provisioning completed

**Current Offering**: We currently offering a Shared Gallery 

**Intake Processes**

| Variable Name   | Description                     |
|------|-------------|
| environment | Name of the environment to be deployed.
| gallery\_name | Name of the gallery.
| images | The object to configure image definitions inside your gallery.
| location | azure region location(canadacentral,canadaeast).
| resource\_group\_name | Name of the resourcegroup the gallery lives in.
| os_type | The type of Operating System present in this Shared Image. Possible values are Linux and Windows. Changing this forces a new resource to be created.
| publisher | The Publisher Name for this Gallery Image.
| sku |  The Name of the SKU for this Gallery Image.
| offer | The Offer Name for this Shared Image. 


***Current spec***
- a Shared Gallery is provisioned
- based on the intake request Image definitions are also created to host image versions
- a supporting storage account is provisioned to temporary hold images

**Overview**
Shared Image Gallery is a service that helps you build structure and organization around your managed images

**Architectural Overview**
<The diagram would need to include CTC DNS name, access path, key storage location, subscription> 

**Detail Design**
- 

**Security Architecture**
- Allows for the storage of image versions allow better auditability

**How to use the service?**
- Images stored in the shared gallery must be created through the ctc enterprise pipeline


**Support processes**


**Troubleshooting**

https://docs.microsoft.com/en-us/azure/virtual-machines/windows/troubleshooting-shared-images


**Incident Alerting/Escalation Processes** 

| Metric/Events                         | Target                  | Response Process    | Threshold |
|---------------------------------------|-------------------------|---------------------|-----------|


**Backup and Availability**
- 

**Disaster Recovery**
- None 

**Maintenance and Patching**
- N/A

**Key Vault**
- N/A

**Access Management**
- Direct access to the gallery is not provided. All process happen through the pipeline

**Provisioning**
- N/A

**To Do**

**References**

https://docs.microsoft.com/en-us/azure/virtual-machines/linux/shared-image-galleries
