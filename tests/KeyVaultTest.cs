namespace KeyVaultTests;

public class KeyVaultTest
{
    [Fact]
    [Trait("Category", "KeyVault")]
    public void Can_Read_Secret()
    {
        var keyVaultName = Environment.GetEnvironmentVariable("KEY_VAULT_NAME");
        var kvUri = new Uri($"https://{keyVaultName}");

        // Create a new secret client
        var client = new SecretClient(kvUri, new DefaultAzureCredential());

        // Retrieve a secret using the secret client.
        var secret = client.GetSecret("secret-value").Value;
        Assert.Equal("one europe", secret.Value);
    }

    [Fact]
    [Trait("Category", "KeyVault")]
    public void CustomEndpointAddress_Resolves_To_Application_Gateway_Private_Ip()
    {
        var keyVaultName = Environment.GetEnvironmentVariable("KEY_VAULT_NAME");
        var gatewayIP = Environment.GetEnvironmentVariable("GATEWAY_IP");
        var ip = Dns.GetHostEntry(keyVaultName!);
        Assert.NotNull(ip);
        Assert.Contains(IPAddress.Parse(gatewayIP!), ip.AddressList);
    }
}