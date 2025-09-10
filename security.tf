
resource "azurerm_network_security_group" "server_nsg" {
  name = "server_nsg"
  location = var.location
  resource_group_name = var.azurerm_resource_group.name

  security_rule {

    name                       = "server_inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"  ##You can replace this part with your own IP if you don't want it exposed to public
    destination_address_prefix = "*"

  }

  security_rule {

    name                       = "server_outbound"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"  
    destination_address_prefix = "*"

  }

}

/// Associate the Security group to the VM's NIC

resource "azurerm_network_interface_security_group_association" "sec_nic_assiociate" {
    network_interface_id = azurerm_network_interface.server-nic.id
    network_security_group_id = azurerm_network_security_group.server_nsg.id
  
}