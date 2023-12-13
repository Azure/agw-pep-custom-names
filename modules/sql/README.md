## SQL Private endpoint Limitations

* Use the Fully Qualified Domain Name (FQDN) of the server in connection strings for your clients (<server>.database.windows.net). **Any login attempts made directly to the IP address or using the private link FQDN (<server>.privatelink.database.windows.net) shall fail.** This behavior is by design, since private endpoint routes traffic to the SQL Gateway in the region and the correct FQDN needs to be specified for logins to succeed.
* Connections to private endpoint only support **Proxy** as the connection policy

## Add Service Principal to SQL Server

``` sql
CREATE USER [<service-principal-name>] FROM EXTERNAL PROVIDER; 
ALTER ROLE db_datareader ADD MEMBER [<service-principal-name>]; 
ALTER ROLE db_datawriter ADD MEMBER [<service-principal-name>]; 
ALTER ROLE db_ddladmin ADD MEMBER [<service-principal-name>]; 
```

References:

* [Azure Private Link for Azure SQL Database and Azure Synapse Analytics](https://docs.microsoft.com/en-us/azure/azure-sql/database/private-endpoint-overview?view=azuresql#check-connectivity-using-sql-server-management-studio-ssms)