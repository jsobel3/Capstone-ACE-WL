# Get Resources from a Resource Group
data "azurerm_resource_group" "NBOS_AZ_RG" {
  name = "${var.resourcegroup_name}${var.az_suffix}"
}

/*# Get Resources with specific Tags
data "azurerm_resources" "NBOS_AZ_RG" {
  resource_group_name = "NBOS-AZ-RG"

  required_tags = {
    environment = "dev"
    role        = "it"
  }
}*/

#Access information about LZ virtual network
data "azurerm_virtual_network" "NBOS_AZ_VN" {
  name                = "NBOS-VN-network${var.az_suffix}"
  resource_group_name = "${var.resourcegroup_name}${var.az_suffix}"
}