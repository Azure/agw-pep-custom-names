namespace Aurora;

public class CosmosFactAttribute : FactAttribute
{
    public CosmosFactAttribute()
    {
        if (!IsCosmosEnabled())
        {
            Skip = "Cosmos Tests are disabled";
        }
    }

    public static bool IsCosmosEnabled()
    {
        return !string.IsNullOrEmpty(Environment.GetEnvironmentVariable("COSMOS_DB_CUSTOM_ENDPOINT"));
    }
}