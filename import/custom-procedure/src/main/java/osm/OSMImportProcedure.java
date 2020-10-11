package osm;

import org.neo4j.graphdb.*;
import org.neo4j.procedure.Context;
import org.neo4j.procedure.Mode;
import org.neo4j.procedure.Name;
import org.neo4j.procedure.Procedure;
import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Stream;

public class OSMImportProcedure {
    public static final RelationshipType EDITED = RelationshipType.withName("EDITED");
    @Context
    public Transaction tx;
    private static Label POINT = Label.label("Point");
    ;
    private static Label USER = Label.label("User");
    ;

    public static class Summary {
        public String value;

        public Summary(String value) {
            this.value = value;
        }
    }

    @Procedure(mode = Mode.WRITE)
    public Stream<Summary> importUri(@Name("uri") String uri) throws ParserConfigurationException, IOException,
            SAXException, XPathExpressionException {
        DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
        domFactory.setNamespaceAware(true);
        DocumentBuilder builder = domFactory.newDocumentBuilder();
        Document doc = builder.parse(uri);
        XPath xpath = XPathFactory.newInstance().newXPath();

        XPathExpression nodeExpression = xpath.compile("//node");
        NodeList nodes = (NodeList) nodeExpression.evaluate(doc, XPathConstants.NODESET);

        Map<String, Node> users = new HashMap<>();

        for (int i = 0; i < nodes.getLength(); i++) {
            org.w3c.dom.Node node = nodes.item(i);
            NamedNodeMap nodeAttributes = node.getAttributes();
            String userName = nodeAttributes.getNamedItem("user").getNodeValue();

            Node user = users.computeIfAbsent(userName, name -> mergeNode(USER, "name", name));

            String pointId = nodeAttributes.getNamedItem("id").getNodeValue();
            org.neo4j.graphdb.Node point = mergeNode(POINT, "id", pointId);
            point.setProperty("latitude", Double.parseDouble(nodeAttributes.getNamedItem("lat").getNodeValue()));
            point.setProperty("longitude", Double.parseDouble(nodeAttributes.getNamedItem("lon").getNodeValue()));

            mergeRelationship(point, user, EDITED);
        }

        return Stream.of(new Summary("OSM data imported"));

    }

    private void mergeRelationship(org.neo4j.graphdb.Node point, org.neo4j.graphdb.Node user,
                                   RelationshipType relationshipType) {
        Relationship editedRelationship = point.getSingleRelationship(relationshipType, Direction.OUTGOING);
        if (editedRelationship == null) {
            point.createRelationshipTo(user, relationshipType);
        }
    }

    private org.neo4j.graphdb.Node mergeNode(Label label, String key, String value) {
        org.neo4j.graphdb.Node point = tx.findNode(label, key, value);
        if (point == null) {
            point = tx.createNode(label);
            point.setProperty(key, value);
        }
        return point;
    }
}
