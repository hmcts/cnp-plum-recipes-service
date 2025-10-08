# Key Vault Secrets
import {
  to = azurerm_key_vault_secret.POSTGRES-USER-V14
  id = "https://plumsi-sandbox.vault.azure.net/secrets/recipe-backend-POSTGRES-USER-v14/ddc2fea4a9ce4a46be54a214cf4bcbe7"
}

import {
  to = azurerm_key_vault_secret.POSTGRES-PASS-V14
  id = "https://plumsi-sandbox.vault.azure.net/secrets/recipe-backend-POSTGRES-PASS-v14/525d7e4b972c4f648fdf5acba1cd0284"
}

import {
  to = azurerm_key_vault_secret.POSTGRES_HOST-V14
  id = "https://plumsi-sandbox.vault.azure.net/secrets/recipe-backend-POSTGRES-HOST-V14/07c2e5a1a6f1461abdc121680324f135"
}

import {
  to = azurerm_key_vault_secret.POSTGRES_PORT-V14
  id = "https://plumsi-sandbox.vault.azure.net/secrets/recipe-backend-POSTGRES-PORT-V14/a841fe458dfd4d51b90be0fa2af55855"
}

import {
  to = azurerm_key_vault_secret.POSTGRES_DATABASE-V14
  id = "https://plumsi-sandbox.vault.azure.net/secrets/recipe-backend-POSTGRES-DATABASE-V14/b86f01ae5c4841e2b6437c0b8eb484fe"
}

import {
  to = module.plum-redis-storage.azurerm_resource_group.cache-resourcegroup[0]
  id = "/subscriptions/bf308a5c-0624-4334-8ff8-8dca9fd43783/resourceGroups/plum-recipe-backend-session-storage-cache-sandbox"
}

import {
  to = module.postgresql_flexible.azurerm_resource_group.rg[0]
  id = "/subscriptions/bf308a5c-0624-4334-8ff8-8dca9fd43783/resourceGroups/plum-v14-flexible-data-sandbox"
}
import {
  to = module.postgresql_flexible.azurerm_postgresql_flexible_server.pgsql_server
  id = "/subscriptions/bf308a5c-0624-4334-8ff8-8dca9fd43783/resourceGroups/plum-v14-flexible-data-sandbox/providers/Microsoft.DBforPostgreSQL/flexibleServers/plum-v14-flexible-sandbox"
}

# Redis Cache
import {
  to = module.plum-redis-storage.azurerm_redis_cache.redis
  id = "/subscriptions/bf308a5c-0624-4334-8ff8-8dca9fd43783/resourceGroups/plum-recipe-backend-session-storage-cache-sandbox/providers/Microsoft.Cache/redis/plum-recipe-backend-session-storage-sandbox"
}

# Private Endpoint for Redis
import {
  to = module.plum-redis-storage.azurerm_private_endpoint.this[0]
  id = "/subscriptions/bf308a5c-0624-4334-8ff8-8dca9fd43783/resourceGroups/plum-recipe-backend-session-storage-cache-sandbox/providers/Microsoft.Network/privateEndpoints/plum-recipe-backend-session-storage-sandbox"
}

# PostgreSQL Databases
import {
  to = module.postgresql_flexible.azurerm_postgresql_flexible_server_database.pg_databases["rhubarb"]
  id = "/subscriptions/bf308a5c-0624-4334-8ff8-8dca9fd43783/resourceGroups/plum-v14-flexible-data-sandbox/providers/Microsoft.DBforPostgreSQL/flexibleServers/plum-v14-flexible-sandbox/databases/rhubarb"
}

import {
  to = module.postgresql_flexible.azurerm_postgresql_flexible_server_database.pg_databases["plum"]
  id = "/subscriptions/bf308a5c-0624-4334-8ff8-8dca9fd43783/resourceGroups/plum-v14-flexible-data-sandbox/providers/Microsoft.DBforPostgreSQL/flexibleServers/plum-v14-flexible-sandbox/databases/plum"
}

# PostgreSQL AD Administrator
import {
  to = module.postgresql_flexible.azurerm_postgresql_flexible_server_active_directory_administrator.pgsql_adadmin
  id = "/subscriptions/bf308a5c-0624-4334-8ff8-8dca9fd43783/resourceGroups/plum-v14-flexible-data-sandbox/providers/Microsoft.DBforPostgreSQL/flexibleServers/plum-v14-flexible-sandbox/administrators/3c52c98b-07a3-4a97-92b9-298e86bb1ca9"
}
