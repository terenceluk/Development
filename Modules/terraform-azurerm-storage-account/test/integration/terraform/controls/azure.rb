title 'terraform storage account config'

storage1 = attribute('storage1')
storage2 = attribute('storage2')
storage3 = attribute('storage3')
storage4_id = attribute('storage4_id')

control 'terraform-azure-01' do
  impact 1.0
    title 'storage_account: Description'
    desc 'Verifies settings and provisioning for a Azure Storage Account and blob'
      describe azurerm_storage_account(resource_group: 'ctc-nonprod-tfmodules-cc-rg', name: storage1) do
        it { should exist }
      end
      describe azurerm_storage_account_blob_container(resource_group: 'ctc-nonprod-tfmodules-cc-rg', storage_account_name: storage1, blob_container_name: 'test1')  do
  	it { should exist }
      end
end

control 'terraform-azure-02' do
  impact 1.0
    title 'storage_account: Description'
    desc 'Verifies bypass correctly set has been created'
      describe azurerm_storage_account(resource_group: 'ctc-nonprod-tfmodules-cc-rg', name: storage2) do            
      	it { should exist }
	its('properties.networkAcls.bypass') { should cmp 'AzureServices' }
      end
end

control 'terraform-azure-03' do
  impact 1.0
    title 'storage_account: Description'
    desc 'Verifies storage account has been created with httpsonly'
      describe azurerm_storage_account(resource_group: 'ctc-nonprod-tfmodules-cc-rg', name: storage3) do
      	it { should exist }
	its('properties.supportsHttpsTrafficOnly') { should be true }
      end
end

control 'terraform-azure-04' do
  impact 1.0
    title 'storage_account: Description'
    desc 'Verifies storage account has been created with custom identity'
      describe azure_generic_resource(resource_id: storage4_id) do
      	it { should exist }
        its ('identity.type') { should cmp 'SystemAssigned,UserAssigned' }
      end
end