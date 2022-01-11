#variables.terraform 
variable "az_suffix" {
  type        = string
  default     = "_jss"
  description = "the suffix used to identify who created the Rescource"
}

variable "az_prefix" {
  type        = string
  default     = "NBOS-AZ"
  description = "the suffix used to identify who/what technology the resource is used for"
}

variable "sql_server_name" {
  type        = string
  description = "SQL Server instance name in Azure"
}

variable "sql_database_name" {
  type        = string
  description = "SQL Database name in Azure"
}

variable "sql_admin_login" {
  type        = string
  description = "SQL Server lognin name in Azure"
}

variable "sql_admin_password" {
  type        = string
  description = "SQL Server password in Azure"
}

variable "resourcegroup_name" {
  type        = string
  default     = "NBOS_AZ_RG"
  description = "link to resource group name in LZ"
}

variable "resourcegroup_location" {
  type        = string
  default     = "eastus2"
  description = "link to resource group location in LZ"
}

variable "virtualnetwork_name" {
  type        = string
  default     = "NBOS-VN-network"
  description = "link to V-network in LZ"
}