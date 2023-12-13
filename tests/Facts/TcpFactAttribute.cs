namespace Aurora;

public class TcpFactAttribute : FactAttribute
{
    public TcpFactAttribute()
    {
        if (!IsGatewayTcpEnabled())
        {
            Skip = "TLS TCP Proxy is disabled";
        }
    }

    public static bool IsGatewayTcpEnabled()
    {
        return Environment.GetEnvironmentVariable("TLS_TCP_PROXY_ENABLED") == "1";
    }
}