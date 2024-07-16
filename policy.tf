resource "azurerm_monitor_action_group" "main" {
  name                = "example-actiongroup"
  resource_group_name = azurerm_resource_group.main.name
  short_name          = "p0action"

  #   webhook_receiver {
  #     name        = "callmyapi"
  #     service_uri = "http://example.com/alert"
  #   }

  email_receiver {
    name          = "sendtoadmin"
    email_address = "rcoffie22@yahoo.com"
  }
}



resource "azurerm_monitor_activity_log_alert" "main" {
  name                = "example-activitylogalert"
  resource_group_name = azurerm_resource_group.main.name
  scopes              = [azurerm_resource_group.main.id]
  description         = "This alert will monitor a specific storage account updates."

  criteria {
    resource_id    = azurerm_windows_virtual_machine.dc01.id
    operation_name = "Microsoft.Compute/virtualMachines/restart/action"
    category       = "Administrative"
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id


  }
}