
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_machine" "server_vm" {
  name = "server"
  location = var.location
    resource_group_name = var.azurerm_resource_group.name

  vm_size = "Standard_D2s_v3"
  network_interface_ids = [azurerm_network_interface.server-nic.id[0]]

  storage_os_disk {
  name = "Server-Storage"
  create_option = "FromImage"
  caching = "ReadWrite"

  }


  os_profile {
    computer_name = "server"
    admin_username = "Hamda"
    admin_password = "Password123!"
  }

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer = "WindowsServer "
    sku = "2019 Datacenter"
    version = "latest"

  }

}

resource "azurerm_network_interface" "server-nic" {
  name = "Server_nic"
  location = var.location
    resource_group_name = var.azurerm_resource_group.name

  ip_configuration {
    name = "ip_config_internal"

    private_ip_address_allocation = "Static"
    private_ip_address = "10.1.0.3"
    subnet_id = var.azurerm_subnet.server_subnet.id
  }
  depends_on = [ azurerm_virtual_network.server_vnet ]

}

resource "azurerm_public_ip" "server_public_ip" {
  name = "server_public_ip"
  location = var.location
    resource_group_name = var.azurerm_resource_group.name
  allocation_method = "Static"
lifecycle {
  prevent_destroy = false
}

depends_on = [ azurerm_virtual_network.server_vnet ]

}