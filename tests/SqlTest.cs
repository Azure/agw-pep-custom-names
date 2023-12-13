namespace SqlTests;

public class SqlTest
{
    [SqlFact]
    [Trait("Category", "Sql")]
    public void Can_Read_Database_Using_User_Password()
    {
        var sqlName = Environment.GetEnvironmentVariable("SQL_NAME");
        var server_name = Environment.GetEnvironmentVariable("SQL_SERVER_NAME");
        var dbName = "contoso";
        var user = "azureadmin";

        var cnnBuilder = new SqlConnectionStringBuilder();
        cnnBuilder.DataSource = sqlName;
        cnnBuilder.InitialCatalog = dbName;
        cnnBuilder.PersistSecurityInfo = true;
        cnnBuilder.UserID = $"{user}@{server_name}"; // If the server name is not specified then Login will fail.
        cnnBuilder.Password = Environment.GetEnvironmentVariable("SQL_PASSWORD");
        cnnBuilder.MultipleActiveResultSets = false;
        cnnBuilder.Encrypt = true;
        cnnBuilder.TrustServerCertificate = true;

        using (var connection = new SqlConnection(cnnBuilder.ConnectionString))
        {
            connection.Open();

            var sql = "SELECT name, collation_name FROM sys.databases";

            using (var command = new SqlCommand(sql, connection))
            {
                using (var reader = command.ExecuteReader())
                {
                    Assert.True(reader.Read());
                }
            }
        }
    }

    // [SqlFact]
    // [Trait("Category", "Sql")]
    // public void Can_Read_Database_Using_AAD()
    // {
    //     var sqlName = Environment.GetEnvironmentVariable("SQL_NAME");
    //     var server_name = Environment.GetEnvironmentVariable("SQL_SERVER_NAME");
    //     var dbName = "contoso";

    //     var credential = new DefaultAzureCredential();
    //     var token = credential.GetToken(new TokenRequestContext(new[] { "https://database.windows.net/.default" }));

    //     using (var connection = new SqlConnection($"Server=tcp:{sqlName};Database={dbName};TrustServerCertificate=true"))
    //     {
    //         connection.AccessToken = token.Token;
    //         connection.Open();

    //         var sql = "SELECT name, collation_name FROM sys.databases";

    //         using (var command = new SqlCommand(sql, connection))
    //         {
    //             using (var reader = command.ExecuteReader())
    //             {
    //                 Assert.True(reader.Read());
    //             }
    //         }
    //     }
    // }

    [SqlFact]
    [Trait("Category", "Sql")]
    public void CustomEndpointAddress_Resolves_To_Application_Gateway_Private_Ip()
    {
        var sqlName = Environment.GetEnvironmentVariable("SQL_NAME");
        var gatewayIP = Environment.GetEnvironmentVariable("GATEWAY_IP");
        var ip = Dns.GetHostEntry(sqlName!);
        Assert.NotNull(ip);
        Assert.Contains(IPAddress.Parse(gatewayIP!), ip.AddressList);
    }
}