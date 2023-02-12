title 'terraform keyvault config'

keyvault1_id = attribute('keyvault1_id')
keyvault2_id = attribute('keyvault2_id')
keyvault3_id = attribute('keyvault3_id')
keyvault4_id = attribute('keyvault4_id')
keyvault5_id = attribute('keyvault5_id')

control 'terraform-azure-keyvault1' do
    impact 1.0
    title 'azure-key-vault: keyvault1'
    desc 'Verifies if Azure Key Vault has been created. And RBAC is enabled.'

    describe azure_generic_resource(resource_id: keyvault1_id) do
        it { should exist }
        its('properties.enableRbacAuthorization') { should be true }
    end
end

control 'terraform-azure-keyvault2' do
    impact 1.0
    title 'azure-key-vault: keyvault2'
    desc 'Verifies if Azure Key Vault has been created.'

    describe azure_generic_resource(resource_id: keyvault2_id) do
        it { should exist }
    end
end

control 'terraform-azure-keyvault3' do
    impact 1.0
    title 'azure-key-vault: keyvault3'
    desc 'Verifies if Azure Key Vault has been created.'

    describe azure_generic_resource(resource_id: keyvault3_id) do
        it { should exist }
    end
end

control 'terraform-azure-keyvault4' do
    impact 1.0
    title 'azure-key-vault: keyvault4'
    desc 'Verifies if Azure Key Vault has been created.'

    describe azure_generic_resource(resource_id: keyvault4_id) do
        it { should exist }
    end
end

control 'terraform-azure-keyvault5' do
  impact 1.0
  title 'azure-key-vault: keyvault5'
  desc 'Verifies if Azure Key Vault has been created.'

  describe azure_generic_resource(resource_id: keyvault5_id) do
      it { should exist }
  end
end

control 'terraform-azure-keyvault4' do
    impact 1.0
    title 'azure-key-vault: keyvault4'
    desc 'Verifies if Azure Key Vault has been created.'

    describe azure_generic_resource(resource_id: keyvault4_id) do
        it { should exist }
    end
end