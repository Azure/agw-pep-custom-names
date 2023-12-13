namespace EventHubsTests;

public class EventHubsTest
{
    [Fact]
    [Trait("Category", "EventHubs")]
    public async Task Can_Send_Events_With_TransportType_AmqpWebSockets_And_CustomEndpointAddress()
    {
        var eventHubNamespace = Environment.GetEnvironmentVariable("EVENT_HUB_NAMESPACE");
        var eventHubName = Environment.GetEnvironmentVariable("EVENT_HUB_NAME");
        var eventHubCustomEndpoint = Environment.GetEnvironmentVariable("EVENT_HUB_CUSTOM_ENDPOINT");

        var producerClientOptions = new EventHubProducerClientOptions()
        {
            ConnectionOptions = new EventHubConnectionOptions()
            {
                TransportType = EventHubsTransportType.AmqpWebSockets,
                CustomEndpointAddress = new Uri($"https://{eventHubCustomEndpoint}")
            }
        };

        // Create a producer client that you can use to send events to an event hub
        await using (var producerClient = new EventHubProducerClient(eventHubNamespace, eventHubName, new DefaultAzureCredential(), producerClientOptions))
        {
            // Create a batch of events 
            using EventDataBatch eventBatch = await producerClient.CreateBatchAsync();

            for (var i = 0; i < 100; i++)
            {
                eventBatch.TryAdd(new EventData(Encoding.UTF8.GetBytes($"event {i}")));
            }

            // Use the producer client to send the batch of events to the event hub
            await producerClient.SendAsync(eventBatch);
        }
    }

    [TcpFact]
    [Trait("Category", "EventHubs")]
    public async Task Can_Send_Events_With_TransportType_AmqpTcp_And_CustomEndpointAddress()
    {
        var eventHubNamespace = Environment.GetEnvironmentVariable("EVENT_HUB_NAMESPACE");
        var eventHubName = Environment.GetEnvironmentVariable("EVENT_HUB_NAME");
        var eventHubCustomEndpoint = Environment.GetEnvironmentVariable("EVENT_HUB_CUSTOM_ENDPOINT");

        var producerClientOptions = new EventHubProducerClientOptions()
        {
            ConnectionOptions = new EventHubConnectionOptions()
            {
                TransportType = EventHubsTransportType.AmqpTcp,
                CustomEndpointAddress = new Uri($"sb://{eventHubCustomEndpoint}")
            }
        };

        // Create a producer client that you can use to send events to an event hub
        await using (var producerClient = new EventHubProducerClient(eventHubNamespace, eventHubName, new DefaultAzureCredential(), producerClientOptions))
        {
            // Create a batch of events 
            using EventDataBatch eventBatch = await producerClient.CreateBatchAsync();

            for (var i = 0; i < 100; i++)
            {
                eventBatch.TryAdd(new EventData(Encoding.UTF8.GetBytes($"event {i}")));
            }

            // Use the producer client to send the batch of events to the event hub
            await producerClient.SendAsync(eventBatch);
        }
    }

    [Fact]
    [Trait("Category", "EventHubs")]
    public void CustomEndpointAddress_Resolves_To_Application_Gateway_Private_Ip()
    {
        var eventHubCustomEndpoint = Environment.GetEnvironmentVariable("EVENT_HUB_CUSTOM_ENDPOINT");
        var gatewayIP = Environment.GetEnvironmentVariable("GATEWAY_IP");
        var ip = Dns.GetHostEntry(eventHubCustomEndpoint!);
        Assert.NotNull(ip);
        Assert.Contains(IPAddress.Parse(gatewayIP!), ip.AddressList);
    }
}