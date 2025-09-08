
resource "azurerm_virtual_network" "server_vnet"{
    name = "Server-Vnet"
  location = var.location
  resource_group_name = var.resource_group_name

  address_space = var.vnetIP
  
}

resource "azurerm_subnet" "server_subnet" {
  name = "Server_subnet"
  resource_group_name = var.resource_group_name
  address_prefixes = var.subnet_IP
  virtual_network_name = var.server_vnet.name

  lifecycle {
    prevent_destroy = false
  }

}
