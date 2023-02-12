Param
(
    [Parameter(Mandatory=$True)]
    [string]$resourcegroupname,
    [Parameter(Mandatory=$True)]
    [string]$recoveryvaultname,
    [Parameter(Mandatory=$True)]
    [string]$fabricname,
    [Parameter(Mandatory=$True)]
    [string]$containername,
    [Parameter(Mandatory=$True)]
    [string]$replicationvmname
)   

$securesecret = ConvertTo-SecureString -String $env:ARM_CLIENT_SECRET -AsPlainText -Force
$Credential = New-Object pscredential($env:ARM_CLIENT_ID,$securesecret)
Connect-AzAccount -Credential $Credential -Tenant $env:ARM_TENANT_ID -ServicePrincipal
Set-AzContext $env:ARM_SUBSCRIPTION_ID
$Vault = Get-AzRecoveryServicesVault -ResourceGroupName $resourcegroupname -Name $recoveryvaultname 
Set-AzRecoveryServicesAsrVaultContext -Vault $Vault 
$fabric = Get-AzRecoveryServicesAsrFabric -Name $fabricname 
$container = Get-ASRProtectionContainer -Fabric $fabric -Name $containername
$ReplicationProtectedItem = Get-ASRReplicationProtectedItem -ProtectionContainer $container -Name $replicationvmname
Remove-AzRecoveryServicesAsrReplicationProtectedItem -ReplicationProtectedItem $ReplicationProtectedItem -Force