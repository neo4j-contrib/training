package com.neo4j.examples;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import org.neo4j.driver.v1.AuthTokens;
import org.neo4j.driver.v1.Driver;
import org.neo4j.driver.v1.GraphDatabase;
import org.neo4j.driver.v1.Record;
import org.neo4j.driver.v1.Session;
import org.neo4j.driver.v1.StatementResult;
import org.neo4j.driver.v1.summary.SummaryCounters;

import static org.neo4j.driver.v1.Values.parameters;

public class Import
{

    public static void main( String[] args )
    {
        if ( args.length < 2 )
        {
            System.out.println( "Usage: mvn exec:java -Dexec.mainClass=\"com.neo4j.examples.Import\" -Dexec" +
                    ".args=\"[Person1 Person2]\"" );
            System.exit( 1 );
        }

        try ( Driver driver = GraphDatabase.driver( "bolt://localhost:7687", AuthTokens.basic( "neo4j", "neo" ) ) )
        {
            try ( Session session = driver.session() )
            {
                String query = "MERGE (p1:Person {name: {person1} }) MERGE (p2:Person {name: {person2} }) MERGE (p1)" +
                        "-[:KNOWS]->(p2)";
                StatementResult result = session.run( query, parameters( "person1", args[0], "person2", args[1] ) );
                System.out.println( summarise(result.summary().counters()) );
            }
        }
    }

    private static String summarise( SummaryCounters counters )
    {
        List<String> statistics = new ArrayList<>();
        if ( counters == null )
        {
            return "";
        }
        if ( counters.nodesCreated() != 0 )
        {
            statistics.add( String.format( "Added %d nodes", counters.nodesCreated() ) );
        }
        if ( counters.nodesDeleted() != 0 )
        {
            statistics.add( String.format( "Deleted %d nodes", counters.nodesDeleted() ) );
        }
        if ( counters.relationshipsCreated() != 0 )
        {
            statistics.add( String.format( "Created %d relationships", counters.relationshipsCreated() ) );
        }
        if ( counters.relationshipsDeleted() != 0 )
        {
            statistics.add( String.format( "Deleted %d relationships", counters.relationshipsDeleted() ) );
        }
        if ( counters.propertiesSet() != 0 )
        {
            statistics.add( String.format( "Set %d properties", counters.propertiesSet() ) );
        }
        if ( counters.labelsAdded() != 0 )
        {
            statistics.add( String.format( "Added %d labels", counters.labelsAdded() ) );
        }
        if ( counters.labelsRemoved() != 0 )
        {
            statistics.add( String.format( "Removed %d labels", counters.labelsRemoved() ) );
        }
        if ( counters.indexesAdded() != 0 )
        {
            statistics.add( String.format( "Added %d indexes", counters.indexesAdded() ) );
        }
        if ( counters.indexesRemoved() != 0 )
        {
            statistics.add( String.format( "Removed %d indexes", counters.indexesRemoved() ) );
        }
        if ( counters.constraintsAdded() != 0 )
        {
            statistics.add( String.format( "Added %d constraints", counters.constraintsAdded() ) );
        }
        if ( counters.constraintsRemoved() != 0 )
        {
            statistics.add( String.format( "Removed %d constraints", counters.constraintsRemoved() ) );
        }
        return statistics.stream().collect( Collectors.joining( ", " ) );
    }
}
