package osm;

import org.junit.Rule;
import org.junit.Test;
import osm.OSMImportProcedure;

import org.neo4j.driver.v1.Config;
import org.neo4j.driver.v1.Driver;
import org.neo4j.driver.v1.GraphDatabase;
import org.neo4j.driver.v1.Session;
import org.neo4j.driver.v1.StatementResult;
import org.neo4j.harness.junit.Neo4jRule;

import static junit.framework.TestCase.assertTrue;

public class OSMImportProcedureTest
{
    // This rule starts a Neo4j instance
    @Rule
    public Neo4jRule neo4j = new Neo4jRule()

            // This is the Procedure we want to test
            .withProcedure( OSMImportProcedure.class );

    @Test
    public void shouldParseXmlFile() throws Throwable
    {
        // In a try-block, to make sure we close the driver after the test
        try( Driver driver = GraphDatabase.driver( neo4j.boltURI() , Config.build().withoutEncryption().toConfig() ) )
        {
            try(Session session = driver.session())
            {
                StatementResult result = session.run(
                        "CALL osm.importUri('http://overpass.osm.rambler.ru/cgi/xapi_meta?*[bbox=11.54,48.14,11.543, 48.145]') YIELD nodesCreated RETURN nodesCreated"
                );

                System.out.println(result.peek());
            }

            // Change the evaluator to filter out paths once they've gone beyond the distance and aren't anywhere near the start node

        }
    }

}
