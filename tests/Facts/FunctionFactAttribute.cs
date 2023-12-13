namespace Aurora;

public class FunctionFactAttribute : FactAttribute
{
    public FunctionFactAttribute()
    {
        if (!IsFunctionEnabled())
        {
            Skip = "Function Tests are disabled";
        }
    }

    public static bool IsFunctionEnabled()
    {
        return !string.IsNullOrEmpty(Environment.GetEnvironmentVariable("FUNCTION_CUSTOM_ENDPOINT"));
    }
}