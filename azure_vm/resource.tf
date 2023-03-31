resource "azurerm_resource_group" "ab_Group" {
  name     = "ab_Group"
  location = var.location

}
resource "azurerm_virtual_network" "ab_virtual_network" {
  name                = "ab_virtual_network"
  resource_group_name = azurerm_resource_group.ab_Group.name
  location            = var.location
  address_space       = ["192.168.0.0/16"]
  depends_on = [
    azurerm_resource_group.ab_Group
  ]
}
resource "azurerm_subnet" "ab_subnet" {
  name                 = "ab_subnet"
  resource_group_name  = azurerm_resource_group.ab_Group.name
  virtual_network_name = azurerm_virtual_network.ab_virtual_network.name
  address_prefixes       = ["192.168.0.0/24"]
  depends_on = [
    azurerm_virtual_network.ab_virtual_network
  ]
}

resource "azurerm_network_interface" "app_vm_network" {
  name                = "app_vm_network"
  location            = azurerm_resource_group.ab_Group.location
  resource_group_name = azurerm_resource_group.ab_Group.name
  ip_configuration {
    name                          = "app_vm_network"
    subnet_id                     = azurerm_subnet.ab_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [
    azurerm_subnet.ab_subnet
  ]


}
resource "azurerm_linux_virtual_machine" "appserver" {
  name                = "appserver"
  location            = azurerm_resource_group.ab_Group.location
  resource_group_name = azurerm_resource_group.ab_Group.name
  admin_password      = "Ab@1060871348"
  admin_username      = "abhish9416"
  source_image_reference {
    offer     = var.image_details.vm_offer
    publisher = var.image_details.vm_publisher
    sku       = var.image_details.vm_sku
    version   = var.image_details.vm_version
  }
  size = var.image_details.vm_size
    os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  network_interface_ids = [
    azurerm_network_interface.app_vm_network.id
  ]
  disable_password_authentication = false
  depends_on = [
    azurerm_network_interface.app_vm_network
  ]
}