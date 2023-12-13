namespace StorageTests;

public class StorageBlobTest
{
    [Fact]
    [Trait("Category", "StorageBlob")]
    public void Can_Create_Container()
    {
        var accountName = Environment.GetEnvironmentVariable("STORAGE_ACCOUNT_NAME");
        var blobContainerUri = new Uri($"https://{accountName}/sample-container");

        // Get a reference to a container named "sample-container" and then create it
        var client = new BlobContainerClient(blobContainerUri, new DefaultAzureCredential());
        client.CreateIfNotExists();
    }

    [Fact]
    [Trait("Category", "StorageBlob")]
    public void CustomEndpointAddress_Resolves_To_Application_Gateway_Private_Ip()
    {
        var accountName = Environment.GetEnvironmentVariable("STORAGE_ACCOUNT_NAME");
        var gatewayIP = Environment.GetEnvironmentVariable("GATEWAY_IP");
        var ip = Dns.GetHostEntry(accountName!);
        Assert.NotNull(ip);
        Assert.Contains(IPAddress.Parse(gatewayIP!), ip.AddressList);
    }
}