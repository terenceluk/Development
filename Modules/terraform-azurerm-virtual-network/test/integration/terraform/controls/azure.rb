title 'terraform azurerm_virtual_network  config'

control 'terraform-azure-01' do
  impact 1.0
  title 'keyvault: Description'
  desc 'resoure_group should exist'
  describe azurerm_virtual_network(resource_group: 'ctc-nonprod-tfmodules-cc-rg', name: 'ctc-nonprod-tfmodules-cc-vnet-01') do
      it               { should exist }
      its('location')  { should eq 'canadacentral' }
  end
end