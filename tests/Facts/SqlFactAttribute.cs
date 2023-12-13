namespace Aurora;

public class SqlFactAttribute : FactAttribute
{
    public SqlFactAttribute()
    {
        if (!IsCosmosEnabled())
        {
            Skip = "Sql Tests are disabled";
        }
    }

    public static bool IsCosmosEnabled()
    {
        return !string.IsNullOrEmpty(Environment.GetEnvironmentVariable("SQL_NAME"));
    }
}