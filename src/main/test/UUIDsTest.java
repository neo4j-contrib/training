import org.junit.Rule;
import org.junit.Test;

import org.neo4j.driver.v1.Driver;
import org.neo4j.driver.v1.GraphDatabase;
import org.neo4j.driver.v1.Session;
import org.neo4j.harness.junit.Neo4jRule;

import static org.junit.Assert.assertNotNull;

public class UUIDsTest
{
    @Rule
    public Neo4jRule neo4j = new Neo4jRule().withFunction( UUIDs.class );

    @Test
    public void should() throws Exception
    {
        try ( Driver driver = GraphDatabase.driver( neo4j.boltURI() ) )
        {
            Session session = driver.session();
            String uuid = session.run( "RETURN create.uuid() AS uuid" )
                    .single().get( 0 ).asString();

            assertNotNull( uuid );
        }
    }
}
