namespace PostgreSqlTest;

public class PostgreSqlTest
{
    [PostgreSqlFact]
    [Trait("Category", "PostgreSql")]
    public async Task Can_Read_Database_Using_User_Password()
    {
        var dbName = "exampledb";
        var user = "azureadmin";
        var server = Environment.GetEnvironmentVariable("POSTGRESQL_NAME");
        var password = Environment.GetEnvironmentVariable("POSTGRESQL_PASSWORD");
        var server_name = Environment.GetEnvironmentVariable("POSTGRESQL_SERVER_NAME");

        var builder = new NpgsqlConnectionStringBuilder
        {
            Host = server,
            Database = dbName,
            Username = $"{user}@{server_name}",
            Password = password,
            SslMode = SslMode.VerifyCA,
            TrustServerCertificate = false
        };

        await using var conn = new NpgsqlConnection(builder.ConnectionString);
        await conn.OpenAsync();
        Assert.True(true);
    }

    [Fact(Skip = "Requires a AAD configuration")]
    [Trait("Category", "PostgreSql")]
    public async Task Can_Read_Database_Using_AAD()
    {
        var dbName = "exampledb";
        var user = Environment.GetEnvironmentVariable("AZURE_CLIENT_ID");
        var server = Environment.GetEnvironmentVariable("POSTGRESQL_NAME");
        var server_name = Environment.GetEnvironmentVariable("POSTGRESQL_SERVER_NAME");

        var credentials = new DefaultAzureCredential();
        var token = await credentials.GetTokenAsync(new TokenRequestContext(new[] { $"https://ossrdbms-aad.database.windows.net/.default" }));

        var builder = new NpgsqlConnectionStringBuilder
        {
            Host = server,
            Database = dbName,
            Username = $"{user}@{server_name}",
            Password = token.Token,
            SslMode = SslMode.VerifyCA,
            TrustServerCertificate = false
        };

        await using var conn = new NpgsqlConnection(builder.ConnectionString);
        await conn.OpenAsync();
        Assert.True(true);
    }

    [PostgreSqlFact]
    [Trait("Category", "PostgreSql")]
    public void CustomEndpointAddress_Resolves_To_Application_Gateway_Private_Ip()
    {
        var sqlName = Environment.GetEnvironmentVariable("POSTGRESQL_NAME");
        var gatewayIP = Environment.GetEnvironmentVariable("GATEWAY_IP");
        var ip = Dns.GetHostEntry(sqlName!);
        Assert.NotNull(ip);
        Assert.Contains(IPAddress.Parse(gatewayIP!), ip.AddressList);
    }
}