package extension.web;

import org.junit.Rule;
import org.junit.*;
import org.neo4j.harness.junit.Neo4jRule;
//import org.neo4j.test.Mute;
import org.neo4j.test.server.HTTP;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;

import static java.util.Arrays.asList;
import static java.util.Collections.singletonMap;
import static org.junit.Assert.*;

public class StaticWebResourceTest {

    private final static String CONTENT = "<html><body><h1>Hello World</h1></body></html>";

    @Rule
    public Neo4jRule server = new Neo4jRule()
            .withConfig("org.neo4j.server.guide.directory","neo4j-home/guides")
            .withExtension("/guides", StaticWebResource.class.getPackage().getName());

 
    @Before public void setUp() throws IOException {
        // todo create / copy file to the server directory neo4j-home/guides
        File guides = new File("neo4j-home","guides");
        guides.mkdirs();
        Writer w = new FileWriter(new File(guides,"test.html"));
        w.write(CONTENT);
        w.close();
    }
    @Test
    public void testConfig() throws Exception {
        String baseUri = server.httpURI().resolve("/guides/").toString();
        HTTP.Response response =
                HTTP.withBaseUri(baseUri).GET("test.html");

        assertEquals(200, response.status());
        String content = response.rawContent();
        System.err.println(content);
        assertEquals(CONTENT, content);
    }


}
