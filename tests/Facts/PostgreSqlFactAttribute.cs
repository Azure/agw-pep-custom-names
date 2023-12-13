namespace Aurora;

public class PostgreSqlFactAttribute : FactAttribute
{
    public PostgreSqlFactAttribute()
    {
        if (!IsCosmosEnabled())
        {
            Skip = "PostgreSql Tests are disabled";
        }
    }

    public static bool IsCosmosEnabled()
    {
        return !string.IsNullOrEmpty(Environment.GetEnvironmentVariable("POSTGRESQL_NAME"));
    }
}