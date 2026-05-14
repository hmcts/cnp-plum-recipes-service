variable "product" {
  default = "plum"
}

variable "component" {}

variable "location" {
  default = "UK South"
}

variable "env" {
}

variable "subscription" {
}

variable "tenant_id" {}

variable "jenkins_AAD_objectId" {
  description = "(Required) The Azure AD object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies."
}

variable "aks_subscription_id" {}

variable "capacity" {
  default = "1"
}

variable "common_tags" {
  type = map(string)
}

# thumbprint of the SSL certificate for API gateway tests
variable "api_gateway_test_certificate_thumbprint" {
  # keeping this empty by default, so that no thumbprint will match
  default = ""
}

variable "autoheal" {
  description = "Enabling Proactive Auto Heal for Webapps"
  default     = "True"
}

variable "private_dns_subscription_id" {
  default = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
}

variable "pgsql_sku" {
  default = "GP_Standard_D2s_v3"
}

variable "rdb_backup_enabled" {
  type        = bool
  default     = false
  description = "Enable RDB persistence for Redis"
}

variable "redis_sku_name" {
  type        = string
  default     = "Balanced_B3"
  description = "Azure Managed Redis SKU. Format: <Tier>_<Size>. Examples: Balanced_B3 (6GB), Balanced_B5 (13GB), MemoryOptimized_M10 (12GB)"
}

variable "persistence_rdb_backup_frequency" {
  type        = string
  default     = "6h"
  description = "RDB backup frequency for Azure Managed Redis. Possible values: 1h, 6h, 12h"
}

variable "service_criticality" {
  description = "Service criticality rating from 1-5."
  type        = number
  default     = 1
}

variable "backup_policy_id" {
  description = "The resource ID of the backup policy to use for PostgreSQL Flexible Server backup. This should be in the format: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DataProtection/backupVaults/{backupVaultName}/backupPolicies/{backupPolicyName}"
  type        = string
  default     = "/subscriptions/8999dec3-0104-4a27-94ee-6588559729d1/resourceGroups/mgmt-infra-prod-rg/providers/Microsoft.DataProtection/backupVaults/cnp-backup-vault/backupPolicies/postgresql-crit4-5"
}

variable "asp_sku_size" {
  type        = string
  description = "SKU size for the App Service Plan (e.g. B1, P1v3)."
  default     = "B1"
}

variable "asp_capacity" {
  description = "Number of workers for the App Service Plan."
  type        = number
  default     = 1
}

