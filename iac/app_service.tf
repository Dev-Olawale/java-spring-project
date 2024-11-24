resource "azurerm_service_plan" "main" {
  name                = var.asp_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "S1"
  os_type             = "Linux"
}

resource "azurerm_linux_web_app" "springboot_react_app" {
  name                = var.lwapp_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
  }

  identity {
    type = "SystemAssigned"
  }
}
