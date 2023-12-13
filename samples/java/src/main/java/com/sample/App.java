package com.example;

import com.azure.core.credential.TokenCredential;
import com.azure.identity.DefaultAzureCredentialBuilder;
import com.azure.messaging.eventhubs.*;

import java.util.Arrays;
import java.util.List;

import static java.nio.charset.StandardCharsets.UTF_8;

public class App 
{
    public static void main( String[] args )
    {
        List<EventData> telemetryEvents = Arrays.asList(
            new EventData("Roast beef".getBytes(UTF_8)),
            new EventData("Cheese".getBytes(UTF_8)),
            new EventData("Tofu".getBytes(UTF_8)),
            new EventData("Turkey".getBytes(UTF_8)));

        TokenCredential credential = new DefaultAzureCredentialBuilder()
            .build();

        EventHubProducerClient producer = new EventHubClientBuilder()
            .credential(
                "Event Hub Namespace Name",
                "Event Hub Name",
                credential)
            .customEndpointAddress("https://<event hub custom endpoint>")
            .buildProducerClient();

        EventDataBatch currentBatch = producer.createBatch();

        for (EventData event : telemetryEvents) {
            if (currentBatch.tryAdd(event)) {
                continue;
            }

            // The batch is full, so we create a new batch and send the batch.
            producer.send(currentBatch);
            currentBatch = producer.createBatch();

            // Add that event that we couldn't before.
            if (!currentBatch.tryAdd(event)) {
                System.err.printf("Event is too large for an empty batch. Skipping. Max size: %s. Event: %s%n",
                    currentBatch.getMaxSizeInBytes(), event.getBodyAsString());
            }
        }

        producer.send(currentBatch);

        System.out.println("Java OK!");
    }
}
