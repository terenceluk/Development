title 'terraform-azurerm-sharedgallery config'

control 'terraform-azure-01' do
  impact 1.0
  title 'service-bus: Description'
  desc 'resoure_group should exist'
  describe azurerm_resource_groups do
    its('names') { should include 'ctc-nonprod-tfmodules-cc-rg' }
  end
end

control 'terraform-azure-02' do
  describe azure_generic_resource(resource_id: '/subscriptions/42c0910c-ba8d-4218-96f2-e8bbcfdb8dc0/resourceGroups/ctc-nonprod-tfmodules-cc-rg/providers/Microsoft.Compute/galleries/ctcnonprodimnagessg') do
    it { should exist }
    its('location') { should eq 'canadacentral' }
     its('properties.provisioningState') { should cmp 'Succeeded' }
  end
end

control 'terraform-azure-03' do
  describe azure_generic_resource(resource_id: '/subscriptions/42c0910c-ba8d-4218-96f2-e8bbcfdb8dc0/resourceGroups/ctc-nonprod-tfmodules-cc-rg/providers/Microsoft.Compute/galleries/ctcnonprodimnagessg/images/rhel-core7') do
    it { should exist }
    its('location') { should eq 'canadacentral' }
     its('properties.provisioningState') { should cmp 'Succeeded' }
  end
end

control 'terraform-azure-04' do
  describe azure_generic_resource(resource_id: '/subscriptions/42c0910c-ba8d-4218-96f2-e8bbcfdb8dc0/resourceGroups/ctc-nonprod-tfmodules-cc-rg/providers/Microsoft.Compute/galleries/ctcnonprodimnagessg/images/win-core') do
    it { should exist }
    its('location') { should eq 'canadacentral' }
     its('properties.provisioningState') { should cmp 'Succeeded' }
  end
end
