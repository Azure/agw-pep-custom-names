## Environment Variables:

Variable                      | Description                    | Sample Value                                               
------------------------------| -------------------------------| ------------------------------------------------------------
AZURE_TENANT_ID               | Tenant Id                      |                                                            
AZURE_CLIENT_ID               | Client Id                      |                                                            
AZURE_CLIENT_SECRET           | Client Secret                  |                                                            
GATEWAY_IP                    | Application Gatewaty IP        | 10.6.1.254
TLS_TCP_PROXY_ENABLED         | True if TLS feature is enabled | 1                                                          
EVENT_HUB_NAME                | EventHub Name                  | acceptancetesteventhub
EVENT_HUB_NAMESPACE           | EventHub Namespace             | evh-0834.servicebus.windows.net
EVENT_HUB_CUSTOM_ENDPOINT     | EventHub Custom Endpoint       | evh.contoso.corp
FUNCTION_CUSTOM_ENDPOINT      | Function Custom Endpoint       | function.contoso.corp
FUNCTION_KUDU_CUSTOM_ENDPOINT | Function Kudu Custom Endpoint  | functionscm.contoso.corp
STORAGE_ACCOUNT_NAME          | Storage Custom Endpoint        | sta.contoso.corp
KEY_VAULT_NAME                | Key Vault Custom Endpoint      | kv.contoso.corp
COSMOS_DB_CUSTOM_ENDPOINT     | Cosmos Custom Endpoint         | cosmos.contoso.corp
COSMOS_DB_KEY                 | Cosmos Primary Key             | 
POSTGRESQL_NAME               | PostgreSQL Custom Endpoint     | postgresql.contoso.corp
POSTGRESQL_SERVER_NAME        | PostgreSQL Server Name         | postgresql-0834
SQL_NAME                      | SQL Custom Endpoint            | sql.contoso.corp
SQL_SERVER_NAME               | SQL Server Name                | sql-0834
SQL_PASSWORD                  | SQL Password                   |

## Run specific test category:

``` shell
dotnet test --filter Category=<Category Name>
```

Categories:

* CosmosDB
* EventHubs
* KeyVault
* StorageBlob
* Function
* PostgreSql
* Sql

## Build Docker image:

``` shell
docker build -t cmendibl3/aurora -f ./Dockerfile ../
```
