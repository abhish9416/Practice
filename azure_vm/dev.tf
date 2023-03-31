variable "location" {
    type = string
    default = "eats-us" 
}
variable "image_details" {
    type = object ({
        vm_offer = string
        vm_publisher = string
        vm_sku = string
        vm_version = string
        vm_size = string
    })
    default = {
      vm_offer = "0001-com-ubuntu-server-focal"
      vm_publisher = "Canonical"
      vm_size = "Standard_B1s"
      vm_sku = "20_04-lts-gen2"
      vm_version = "latest"
    } 
}
