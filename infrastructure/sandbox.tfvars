api_gateway_test_certificate_thumbprint = "4A98AB1CFFBA46CACBC7D8D3E10FDA667261DFAA"
rdb_backup_enabled                      = false
family                                  = "C"
sku_name                                = "Basic"
rdb_backup_max_snapshot_count           = "1"
pgsql_sku                               = "B_Standard_B1ms"
asp_sku_size                            = "B1"
asp_capacity                            = 1


# Redis configuration for demo
redis_sku_name                   = "Balanced_B3" # 6GB, zone-redundant, suitable for non-prod
persistence_rdb_backup_frequency = "6h"          # Default if backups enabled later