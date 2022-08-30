# 1.0 : EJB : 22/07/2022 : Creation variables locales

locals {
  
  environnement = var.environnement
  module = var.module
  dc = var.datacenter
  platforme = var.platforme
  resource_name_prefix = "${var.platforme}-${var.environnement}-${var.datacenter}"
    common_tags = {
    environment = local.environnement
    datacenter = local.dc
    platforme = local.platforme
  }

    web_common_tags = {
    environment = local.environnement
    datacenter = local.dc
    platforme = local.platforme
    module = var.module
  }

    ws_common_tags = {
    environment = local.environnement
    datacenter = local.dc
    platforme = local.platforme
    module = "kycrt"
  }

    bastion_common_tags = {
    environment = local.environnement
    datacenter = local.dc
    platforme = local.platforme
    module = "bastion"
  }
} 