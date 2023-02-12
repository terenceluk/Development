title 'terraform keyvault  config'

control 'terraform-azure-01' do
  impact 1.0
  title 'keyvault: Description'
  desc 'resoure_group should exist'
  describe azurerm_subnet(resource_group: 'ctc-nonprod-tfmodules-cc-rg', vnet: 'test-vnet', name: 'test-vnet-subnet01-snet') do
      it { should exist }
      its('address_prefix') { should eq '10.0.0.0/24' }
      its('nsg') { should eq 'nsg-test'}
  end
end


