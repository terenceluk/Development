title 'terraform terraform-azurerm-keyvault-secret  config'

control 'terraform-azure-01' do
  impact 1.0
  title 'terraform-azurerm-keyvault-secret: Description'
  desc 'resoure_group should exist'
  describe azurerm_resource_groups do
    its('names') { should include 'ctc-nonprod-tfmodules-cc-rg' }
  end
end
