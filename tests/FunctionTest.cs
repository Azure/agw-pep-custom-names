namespace FunctionTests;

public class FunctionTest
{
    // HttpClient is intended to be instantiated once per application, rather than per-use. See Remarks.
    static readonly HttpClient client = new HttpClient();


    [FunctionFact]
    [Trait("Category", "Function")]
    public async Task Request_to_Function_Returns_200()
    {
        var functionCustomEndpoint = Environment.GetEnvironmentVariable("FUNCTION_CUSTOM_ENDPOINT");

        var response = await client.GetAsync($"https://{functionCustomEndpoint}");
        var message = response.EnsureSuccessStatusCode();
        Assert.Equal(HttpStatusCode.OK, message.StatusCode);
    }

    [FunctionFact]
    [Trait("Category", "Function")]
    public void CustomEndpointAddress_Resolves_To_Application_Gateway_Private_Ip()
    {
        var functionCustomEndpoint = Environment.GetEnvironmentVariable("FUNCTION_CUSTOM_ENDPOINT");
        var gatewayIP = Environment.GetEnvironmentVariable("GATEWAY_IP");
        var ip = Dns.GetHostEntry(functionCustomEndpoint!);
        Assert.NotNull(ip);
        Assert.Contains(IPAddress.Parse(gatewayIP!), ip.AddressList);
    }

    [FunctionFact]
    [Trait("Category", "Function")]
    public void ScmCustomEndpointAddress_Resolves_To_Application_Gateway_Private_Ip()
    {
        var functionCustomEndpoint = Environment.GetEnvironmentVariable("FUNCTION_KUDU_CUSTOM_ENDPOINT");
        var gatewayIP = Environment.GetEnvironmentVariable("GATEWAY_IP");
        var ip = Dns.GetHostEntry(functionCustomEndpoint!);
        Assert.NotNull(ip);
        Assert.Contains(IPAddress.Parse(gatewayIP!), ip.AddressList);
    }
}