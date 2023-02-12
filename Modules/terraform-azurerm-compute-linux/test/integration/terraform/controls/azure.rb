title 'terraform linux vm config'

vm_id = attribute('vm_id')

control 'terraform-azure-compute-linux' do
  desc 'linux vm'
  describe azure_generic_resource(resource_id: vm_id) do
    it { should exist }
    its('location') { should eq 'canadacentral' }
    its('properties.provisioningState') { should cmp 'Succeeded' }
    its('properties.hardwareProfile.vmSize') { should eq 'Standard_D2s_v3' }
  end
end