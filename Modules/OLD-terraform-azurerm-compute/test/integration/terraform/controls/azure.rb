title 'terraform resource_group config'

control 'azurerm_virtual_machine' do
  describe azurerm_virtual_machine(resource_group: 'ctc-sandbox-coa-cc-rg', name: 't9icazcoa01') do
    it                                { should exist }
    its('type')                       { should eq 'Microsoft.Compute/virtualMachines' }
    its('location')                   { should eq('canadacentral') }
    its('os_disk_name')               { should eq('osdisk-t9icazcoa01-01') }
    its('data_disk_names')            { should include('datadisk-t9icazcoa01-01') }
  end
end

control 'azurerm_network_interface' do
  describe azurerm_network_interface(resource_group: 'ctc-sandbox-coa-cc-rg', name: 'nic-t9icazcoa01') do
    it { should exist }
    its('id') { should cmp '/subscriptions/e321efb2-bff7-4ec0-a4a7-c5f95abef641/resourceGroups/ctc-sandbox-coa-cc-rg/providers/Microsoft.Network/networkInterfaces/nic-t9icazcoa01' }
    its('location') { should cmp 'canadacentral' }
    its('name') { should cmp 'nic-t9icazcoa01' }
  end
end
