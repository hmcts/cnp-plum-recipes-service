api_gateway_test_certificate_thumbprint = "4A98AB1CFFBA46CACBC7D8D3E10FDA667261DFAA"
rdb_backup_enabled                      = false
family                                  = "C"
sku_name                                = "Basic"
rdb_backup_max_snapshot_count           = "1"
pgsql_sku                               = "B_Standard_B1ms"
asp_sku_size                            = "B1"
asp_capacity                            = 1

redis_access_policy_assignments = {
    "Data Owner" = {
        create-default-mi  = {}                                                          # new MI, named: myapp-cache-sandbox-api-service-mi
        custom-name-mi     = { display_name = "my-redis-example-mi" }                          # new MI, custom name
        add-existing-user = { object_id = "e132cb6e-b6eb-4aa6-b641-b4d7ed03a422" }     # pre-existing user, no MI created
    }
}