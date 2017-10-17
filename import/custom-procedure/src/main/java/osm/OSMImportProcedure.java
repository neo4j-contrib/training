package osm;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Stream;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import org.neo4j.graphdb.Direction;
import org.neo4j.graphdb.GraphDatabaseService;
import org.neo4j.graphdb.Label;
import org.neo4j.graphdb.Node;
import org.neo4j.graphdb.Relationship;
import org.neo4j.graphdb.RelationshipType;
import org.neo4j.graphdb.Transaction;
import org.neo4j.procedure.Context;
import org.neo4j.procedure.Mode;
import org.neo4j.procedure.Name;
import org.neo4j.procedure.Procedure;

public class OSMImportProcedure
{
    public static final RelationshipType EDITED = RelationshipType.withName( "EDITED" );
    @Context
    public GraphDatabaseService db;
    private static Label POINT = Label.label( "Point" );;
    private static Label USER = Label.label( "User" );;

    public static class Summary
    {
        public String value;

        public Summary( String value )
        {
            this.value= value;
        }
    }

    @Procedure(mode = Mode.WRITE)
    public Stream<Summary> importUri( @Name("uri") String uri ) throws ParserConfigurationException, IOException,
            SAXException, XPathExpressionException
    {
        DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();
        domFactory.setNamespaceAware( true );
        DocumentBuilder builder = domFactory.newDocumentBuilder();
        Document doc = builder.parse( uri );
        XPath xpath = XPathFactory.newInstance().newXPath();

        XPathExpression nodeExpression = xpath.compile( "//node" );
        NodeList nodes = (NodeList) nodeExpression.evaluate( doc, XPathConstants.NODESET );

        Map<String, Node> users = new HashMap<>();

        for ( int i = 0; i < nodes.getLength(); i++ )
        {
            org.w3c.dom.Node node = nodes.item( i );
            NamedNodeMap nodeAttributes = node.getAttributes();
            String userName = nodeAttributes.getNamedItem( "user" ).getNodeValue();

            Node user = users.computeIfAbsent( userName, name ->
            {
                Node u = db.findNode( USER, "name", name );
                if ( u == null )
                {
                    u = db.createNode( USER );
                    u.setProperty( "name", name );
                }
                return u;
            } );

            String pointId = nodeAttributes.getNamedItem( "id" ).getNodeValue();
            org.neo4j.graphdb.Node point = mergeNode( POINT, "id", pointId );
            point.setProperty( "latitude", Double.parseDouble( nodeAttributes.getNamedItem( "lat" ).getNodeValue() ) );
            point.setProperty( "longitude", Double.parseDouble( nodeAttributes.getNamedItem( "lon" ).getNodeValue() ) );

            mergeRelationship( point, user, EDITED );
        }

        return Stream.of( new Summary("OSM data imported") );

    }

    private void mergeRelationship( org.neo4j.graphdb.Node point, org.neo4j.graphdb.Node user,
                                    RelationshipType relationshipType )
    {
        Relationship editedRelationship = point.getSingleRelationship( relationshipType, Direction.OUTGOING );
        if(editedRelationship == null)
        {
            point.createRelationshipTo( user, relationshipType );
        }
    }

    private org.neo4j.graphdb.Node mergeNode( Label label, String key, String value )
    {
        org.neo4j.graphdb.Node point = db.findNode( label, key, value );
        if ( point == null )
        {
            point = db.createNode( label );
            point.setProperty( key, value );
        }
        return point;
    }
}
