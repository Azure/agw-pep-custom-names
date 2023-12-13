import logging
import sys
import certifi
from azure.eventhub import EventData, EventHubProducerClient, TransportType
from azure.identity import EnvironmentCredential

# print(certifi.where())

credential = EnvironmentCredential()

producer = EventHubProducerClient(
    fully_qualified_namespace="<Event Hub Namespace>", 
    eventhub_name="<Event Hub Name>",
    credential=credential,
    logging_enable=True,  # To enable network tracing log, set logging_enable to True.
    retry_total=0,  # Retry up to 3 times to re-do failed operations.
    custom_endpoint_address = "sb://<event hub custom endpoint>:5671")

with producer:
    event_data_batch = producer.create_batch()
    event_data_batch.add(EventData('Message inside EventBatchData'))
    producer.send_batch(event_data_batch)

print('Finished sending.')