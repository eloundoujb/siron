locals {
    app_gw_front_end_port_name  = "app-gw-front-port-name"
    app_gw_front_end_ip_name = "app-gw-front-ip-name"
    app_gw_ip_conf_name  = "app-gw-ip-conf-name"
    app_gw_listener_name  = "app-gw-listener-name"
    app_gw_req_rule1_name  = "app-gw-req-rule1-name"
    app_gw_backend_pool_name1  = "app-gw-backend-name1"
    app_gw_http_name1 = "app-gw-req-rule1-name1"
    app_gw_probe_name1 = "app-gw-req-rule1-name1"
}

resource "azurerm_application_gateway" "app_gateway" {
    name = "${local.resource_name_prefix}-app-gw"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    sku {
      name = "Standard_v2"  
      tier = "Standard_v2"  
    }

    autoscale_configuration {
     max_capacity = 10
     min_capacity = 0 
    }

    gateway_ip_configuration {
      name = local.app_gw_ip_conf_name
      subnet_id = azurerm_subnet.app_gw_subnet.id
    }

    frontend_port {
      name = local.app_gw_front_end_port_name
      port = 80
    }
    frontend_ip_configuration {
      name = local.app_gw_front_end_ip_name
      public_ip_address_id = azurerm_public_ip.app_gw_pip.id
    }

    http_listener {
      name = local.app_gw_listener_name
      frontend_ip_configuration_name = local.app_gw_front_end_ip_name
      frontend_port_name = local.app_gw_front_end_port_name
      protocol = "Http"
    }

    #Application 
    backend_address_pool {
      name = local.app_gw_backend_pool_name1
    }

    backend_http_settings {
      name = local.app_gw_http_name1
      cookie_based_affinity = "Disabled"
      port = 80
      protocol = "Http"
      #path = "/app1/"
      probe_name = local.app_gw_probe_name1
      request_timeout = 60
    }   

    probe {
      name = local.app_gw_probe_name1
      host = "127.0.0.1"
      interval = 30
      timeout = 30
      protocol = "Http"
      unhealthy_threshold = 3
      port = 80
      path = "/app1/status.html"
      match {
        body = "App1"
        status_code = [200]
      }
    }

    request_routing_rule {
      name = local.app_gw_req_rule1_name
      http_listener_name = local.app_gw_listener_name
      rule_type = "Basic"
      backend_address_pool_name = local.app_gw_backend_pool_name1
      backend_http_settings_name = local.app_gw_http_name1
    }
}