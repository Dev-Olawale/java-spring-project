resource "azurerm_application_insights" "main" {
  name                = var.insight_name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "java"
  retention_in_days   = 30
}

resource "null_resource" "application_insights_connection_string" {
  triggers = {
    key = "${azurerm_linux_web_app.springboot_react_app.identity[0].principal_id}:${azurerm_application_insights.main.instrumentation_key}"
  }

  provisioner "local-exec" {
    command = "az webapp config appsettings set --ids ${azurerm_linux_web_app.springboot_react_app.id} --settings APPLICATIONINSIGHTS_INSTRUMENTATION_KEY='${azurerm_application_insights.main.instrumentation_key}' APPLICATIONINSIGHTS_CONNECTION_STRING='${azurerm_application_insights.main.connection_string}' APPLICATIONINSIGHTS_INSTRUMENTATION_LOGGING_LEVEL='INFO' ApplicationInsightsAgent_EXTENSION_VERSION='~2' --output none"
  }
}
