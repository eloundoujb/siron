/*
#Creation de divers profile pour auto-scale 

resource "azurerm_monitor_autoscale_setting" "ws_vmss_autoscale" {
    name = "${local.resource_name_prefix}-${local.module}-ws-vmss-autoscale"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    target_resource_id = azurerm_linux_virtual_machine_scale_set.ws_linux_vmss.id
    enabled = true

    #Notification block
    notification {
      email {
        send_to_subscription_administrator = true
        send_to_subscription_co_administrator = true
        custom_emails = ["barel.eloundou@orange.com","eloundoujb@gmail.com","lekassalouis13@gmail.com"]
      }
    }

    ###########################################    Default Profil    ###########################################
    profile {
      name = "Default"
      capacity {
        minimum = 2
        default = 2
        maximum = 4
      }
      rule {        #Rule Scale In CPU > 75
        scale_action {
          direction = "Increase"
          type = "ChangeCount"
          value = 1
          cooldown = "PT5M"
        }
        metric_trigger {
          metric_name = "Percentage CPU"
          metric_resource_id = azurerm_linux_virtual_machine_scale_set.ws_linux_vmss.id
          metric_namespace = "microsoft.compute/virtualmachinescalesets"
          operator = "GreaterThan"
          statistic = "Average"
          threshold = 75
          time_aggregation = "Average"
          time_grain = "PT1M"
          time_window = "PT5M"
        }
      }
      rule {        #Rule Scale In CPU < 25
        scale_action {
          direction = "Decrease"
          type = "ChangeCount"
          value = 1
          cooldown = "PT5M"
        }
        metric_trigger {
          metric_name = "Percentage CPU"
          metric_resource_id = azurerm_linux_virtual_machine_scale_set.ws_linux_vmss.id
          metric_namespace = "microsoft.compute/virtualmachinescalesets"
          operator = "LessThan"
          statistic = "Average"
          threshold = 25
          time_aggregation = "Average"
          time_grain = "PT1M"
          time_window = "PT5M"
        }
      }
    rule {        #Rule Scale In Memory > 4294967296
      scale_action {
        direction = "Increase"
        type = "ChangeCount"
        value = 1
        cooldown = "PT5M"
      }
      metric_trigger {
        metric_name = "Available Memory Bytes"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.ws_linux_vmss.id
        metric_namespace = "microsoft.compute/virtualmachinescalesets"
        operator = "GreaterThan"
        statistic = "Average"
        threshold = 4294967296
        time_aggregation = "Average"
        time_grain = "PT1M"
        time_window = "PT5M"
      }
    }
    rule {        #Rule Scale In Memory < 1073741824
      scale_action {
        direction = "Decrease"
        type = "ChangeCount"
        value = 1
        cooldown = "PT5M"
      }
      metric_trigger {
        metric_name = "Available Memory Bytes"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.ws_linux_vmss.id
        metric_namespace = "microsoft.compute/virtualmachinescalesets"
        operator = "LessThan"
        statistic = "Average"
        threshold = 1073741824
        time_aggregation = "Average"
        time_grain = "PT1M"
        time_window = "PT5M"
      }
    }
  }  
  ###########################################   End Default Profil     ########################################### 
}
*/