import java.util.UUID;

import org.neo4j.procedure.Description;
import org.neo4j.procedure.UserFunction;

public class UUIDs
{
    @UserFunction("create.uuid")
    @Description("creates an UUID (universally unique id)")
    public String uuid()
    {
        return UUID.randomUUID().toString();
    }
}
