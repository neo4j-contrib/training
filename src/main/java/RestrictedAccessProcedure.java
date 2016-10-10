import java.io.IOException;
import java.util.Map;
import java.util.stream.Stream;

import org.neo4j.graphdb.GraphDatabaseService;
import org.neo4j.graphdb.Node;
import org.neo4j.kernel.api.exceptions.InvalidArgumentsException;
import org.neo4j.procedure.Context;
import org.neo4j.procedure.Description;
import org.neo4j.procedure.Mode;
import org.neo4j.procedure.Name;
import org.neo4j.procedure.Procedure;

import static org.neo4j.helpers.collection.MapUtil.map;

public class RestrictedAccessProcedure
{
    @Context
    public GraphDatabaseService db;

    @Description( "Find movies by an actor" )
    @Procedure( name = "training.moviesOnly", allowed = "movies_only", mode = Mode.READ )
    public Stream<Movie> moviesOnly( @Name( "name" ) String name )
            throws InvalidArgumentsException, IOException
    {
        String query = "MATCH (:Person {name: {name}})-[:ACTED_IN]->(movie) RETURN movie";
        return db.execute( query, map("name", name) )
                .stream()
                .map( Movie::new );
    }

    public static class Movie
    {
        public String title;

        public Movie( Map<String, Object> row )
        {
            Node movie = (Node) row.get( "movie" );
            this.title = movie.getProperty( "title" ).toString();
        }
    }
}

