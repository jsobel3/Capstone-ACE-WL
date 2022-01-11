# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}


#Create App Service Plan
resource "azurerm_app_service_plan" "NBOS_AZ_ASP" {
  name                = "${var.az_prefix}-appserviceplan"
  location            = data.azurerm_resource_group.NBOS_AZ_RG.location
  resource_group_name = data.azurerm_resource_group.NBOS_AZ_RG.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

#Create App Service
resource "azurerm_app_service" "NBOS_AZ_AS" {
  name                = "${var.az_prefix}-app-service"
  location            = data.azurerm_resource_group.NBOS_AZ_RG.location
  resource_group_name = data.azurerm_resource_group.NBOS_AZ_RG.name
  app_service_plan_id = azurerm_app_service_plan.NBOS_AZ_ASP.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=tcp:azurerm_sql_server.NBOS_AZ_sqlserver.fully_qualified_domain_name Database=azurerm_sql_database.NBOS_AZ_DB.name;User ID=azurerm_sql_server.NBOS_AZ_sqlsedrver.administrator_login;Password=azurerm_sql_server.NBOS_AZ_sqlserver.administrator_login_password;Trusted_Connection=False;Encrypt=True;"
  }
}

resource "azurerm_function_app" "NBOS_AZ_FA" {
  name                       = "NBOS-AZ-functions"
  location                   = data.azurerm_resource_group.NBOS_AZ_RG.location
  resource_group_name        = data.azurerm_resource_group.NBOS_AZ_RG.name
  app_service_plan_id        = azurerm_app_service_plan.NBOS_AZ_ASP.id
  storage_account_name       = azurerm_storage_account.NBOS_AZ_SA.name
  storage_account_access_key = azurerm_storage_account.NBOS_AZ_SA.primary_access_key
}

#Create SQL server
resource "azurerm_sql_server" "NBOS_AZ_sqlserver" {
  name                         = "nbossqlserver"
  resource_group_name          = data.azurerm_resource_group.NBOS_AZ_RG.name
  location                     = data.azurerm_resource_group.NBOS_AZ_RG.location
  version                      = "12.0"
  administrator_login          = "mradministrator"
  administrator_login_password = "thisIsDog11"
}

resource "azurerm_storage_account" "NBOS_AZ_SA" {
  name                     = "nbossa"
  resource_group_name      = data.azurerm_resource_group.NBOS_AZ_RG.name
  location                 = data.azurerm_resource_group.NBOS_AZ_RG.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

#Create SQL DB
resource "azurerm_sql_database" "NBOS_AZ_DB" {
  name                = "nbossqldb"
  resource_group_name = data.azurerm_resource_group.NBOS_AZ_RG.name
  location            = data.azurerm_resource_group.NBOS_AZ_RG.location
  server_name         = azurerm_sql_server.NBOS_AZ_sqlserver.name

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.NBOS_AZ_SA.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.NBOS_AZ_SA.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }



  tags = {
    environment = "production"
  }
}