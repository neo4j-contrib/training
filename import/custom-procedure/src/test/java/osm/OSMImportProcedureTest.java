package osm;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.neo4j.driver.Driver;
import org.neo4j.driver.GraphDatabase;
import org.neo4j.driver.Result;
import org.neo4j.driver.Session;
import org.neo4j.harness.Neo4j;
import org.neo4j.harness.Neo4jBuilders;

import static org.junit.Assert.assertEquals;

public class OSMImportProcedureTest
{

    private static Neo4j neo4j;

    @BeforeAll
    static void initializeNeo4j() {
        neo4j = Neo4jBuilders.newInProcessBuilder()
                .withDisabledServer() // No need for http
                .withProcedure(OSMImportProcedure.class)
        .build();
    }

    @Test
    public void shouldParseXmlFile() throws Throwable
    {
        // In a try-block, to make sure we close the driver after the test
        try( Driver driver = GraphDatabase.driver( neo4j.boltURI() ) )
        {
            try(Session session = driver.session())
            {
                Result result = session.run(
                        "CALL osm.importUri('https://overpass-api.de/api/xapi_meta?*[bbox=11.54,48.14,11.543, 48.145]') YIELD value RETURN value"
                );
                result.consume();
            }

            try(Session session = driver.session())
            {
                Result result = session.run( "MATCH (:Point) RETURN count(*) AS count" );
                assertEquals(2199, result.peek().get( "count" ).asInt());
                result.consume();
            }
        }
    }
}
