
##This script sets up a domain for the server 

resource "azurerm_virtual_machine_extension" "server_script" {

  name = "InstallAD"
  virtual_machine_id = azurerm_virtual_machine.server_vm.id
  type = "CustomScriptExtension"
  publisher = "Microsoft.compute"
  type_handler_version = "1.10"


   settings = <<SETTINGS
  {
    "commandToExecute": "powershell.exe -ExecutionPolicy Unrestricted -Command \"if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) { Write-Host 'This script must be run as Administrator.'; exit }; Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools; Import-Module ADDSDeployment; Install-ADDSForest -DomainName 'TestDomain.local' -DomainNetbiosName 'TESTDOMAIN' -SafeModeAdministratorPassword (ConvertTo-SecureString 'P@ssw0rd123!' -AsPlainText -Force) -InstallDNS -Force -NoRebootOnCompletion; Restart-Computer -Force\""
  }
  SETTINGS

  depends_on = [ azurerm_virtual_machine.server_vm]

}