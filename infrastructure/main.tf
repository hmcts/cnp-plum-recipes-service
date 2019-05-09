provider "azurerm" {
  version = "1.22.1"
}

locals {
  app        = "recipe-backend"
  create_api = "${var.env != "preview" && var.env != "spreview"}"

  # list of the thumbprints of the SSL certificates that should be accepted by the API (gateway)
  allowed_certificate_thumbprints = [
    # API tests
    "${var.api_gateway_test_certificate_thumbprint}",
  ]

  thumbprints_in_quotes     = "${formatlist("&quot;%s&quot;", local.allowed_certificate_thumbprints)}"
  thumbprints_in_quotes_str = "${join(",", local.thumbprints_in_quotes)}"
  api_policy                = "${replace(file("template/api-policy.xml"), "ALLOWED_CERTIFICATE_THUMBPRINTS", local.thumbprints_in_quotes_str)}"
  api_base_path             = "plum-recipes-api"
  shared_infra_rg           = "${var.product}-shared-infrastructure-${var.env}"
  vault_name                = "${var.product}si-${var.env}"
}

module "recipe-backend" {
  source                 = "git@github.com:hmcts/cnp-module-webapp?ref=master"
  product                = "${var.product}-${local.app}"
  location               = "${var.location}"
  env                    = "${var.env}"
  ilbIp                  = "${var.ilbIp}"
  subscription           = "${var.subscription}"
  is_frontend            = false
  capacity               = "${var.capacity}"
  common_tags            = "${var.common_tags}"
  java_container_version = "9.0"
  java_version           = "11"

  appinsights_instrumentation_key = "${data.azurerm_key_vault_secret.appInsights-InstrumentationKey.value}"

  app_settings = {
    POSTGRES_HOST                      = "${module.recipe-database.host_name}"
    POSTGRES_PORT                      = "${module.recipe-database.postgresql_listen_port}"
    POSTGRES_DATABASE                  = "${module.recipe-database.postgresql_database}"
    POSTGRES_USER                      = "${module.recipe-database.user_name}"
    POSTGRES_PASSWORD                  = "${module.recipe-database.postgresql_password}"
    WEBSITE_PROACTIVE_AUTOHEAL_ENABLED = "${var.autoheal}"
    FORCE_RUN                          = "run-please2"
  }
}

data "azurerm_key_vault" "key_vault" {
  name                = "${local.vault_name}"
  resource_group_name = "${local.shared_infra_rg}"
}

data "azurerm_key_vault_secret" "appInsights-InstrumentationKey" {
  name         = "appInsights-InstrumentationKey"
  key_vault_id = "${data.azurerm_key_vault.key_vault.id}"
}

resource "azurerm_key_vault_secret" "POSTGRES-USER" {
  name         = "recipe-backend-POSTGRES-USER"
  value        = "${module.recipe-database.user_name}"
  key_vault_id = "${data.azurerm_key_vault.key_vault.id}"
}

resource "azurerm_key_vault_secret" "POSTGRES-PASS" {
  name         = "recipe-backend-POSTGRES-PASS"
  value        = "${module.recipe-database.postgresql_password}"
  key_vault_id = "${data.azurerm_key_vault.key_vault.id}"
}

resource "azurerm_key_vault_secret" "POSTGRES_HOST" {
  name         = "recipe-backend-POSTGRES-HOST"
  value        = "${module.recipe-database.host_name}"
  key_vault_id = "${data.azurerm_key_vault.key_vault.id}"
}

resource "azurerm_key_vault_secret" "POSTGRES_PORT" {
  name         = "recipe-backend-POSTGRES-PORT"
  value        = "${module.recipe-database.postgresql_listen_port}"
  key_vault_id = "${data.azurerm_key_vault.key_vault.id}"
}

resource "azurerm_key_vault_secret" "POSTGRES_DATABASE" {
  name         = "recipe-backend-POSTGRES-DATABASE"
  value        = "${module.recipe-database.postgresql_database}"
  key_vault_id = "${data.azurerm_key_vault.key_vault.id}"
}

module "recipe-database" {
  source             = "git@github.com:hmcts/cnp-module-postgres?ref=master"
  product            = "${var.product}"
  location           = "${var.location}"
  env                = "${var.env}"
  postgresql_user    = "rhubarbadmin"
  database_name      = "rhubarb"
  postgresql_version = "10"
  sku_name           = "GP_Gen5_2"
  sku_tier           = "GeneralPurpose"
  storage_mb         = "51200"
  common_tags        = "${var.common_tags}"
}

# region API (gateway)

data "template_file" "api_template" {
  template = "${file("${path.module}/template/api.json")}"
}

resource "azurerm_template_deployment" "api" {
  template_body       = "${data.template_file.api_template.rendered}"
  name                = "${var.product}-api-${var.env}"
  deployment_mode     = "Incremental"
  resource_group_name = "core-infra-${var.env}"
  count               = "${local.create_api ? 1 : 0}"

  parameters = {
    apiManagementServiceName = "core-api-mgmt-${var.env}"
    apiName                  = "${var.product}-recipes-api"
    apiProductName           = "${var.product}-recipes"
    serviceUrl               = "http://${var.product}-${local.app}-${var.env}.service.core-compute-${var.env}.internal"
    apiBasePath              = "${local.api_base_path}"
    policy                   = "${local.api_policy}"
  }
}

# endregion

