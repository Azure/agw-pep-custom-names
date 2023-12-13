namespace CosmosDBTests;

public class CosmosDBTest
{
    [CosmosFact]
    [Trait("Category", "CosmosDB")]
    public async void Can_Create_Database()
    {
        var endpoint = $"https://{Environment.GetEnvironmentVariable("COSMOS_DB_CUSTOM_ENDPOINT")}";
        var key = Environment.GetEnvironmentVariable("COSMOS_DB_KEY");
        
        var builder = new CosmosClientBuilder(endpoint, key)
            .WithLimitToEndpoint(true)
            .WithConnectionModeGateway();

        var client = builder.Build();
        var database = await client.CreateDatabaseIfNotExistsAsync("oneeurope");
        Assert.True(true);
    }

    [CosmosFact]
    [Trait("Category", "CosmosDB")]
    public void CustomEndpointAddress_Resolves_To_Application_Gateway_Private_Ip()
    {
        var cosmosCustomEndpoint = Environment.GetEnvironmentVariable("COSMOS_DB_CUSTOM_ENDPOINT");
        var gatewayIP = Environment.GetEnvironmentVariable("GATEWAY_IP");
        var ip = Dns.GetHostEntry(cosmosCustomEndpoint!);
        Assert.NotNull(ip);
        Assert.Contains(IPAddress.Parse(gatewayIP!), ip.AddressList);
    }
}