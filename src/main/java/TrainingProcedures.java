import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

import org.neo4j.graphalgo.CommonEvaluators;
import org.neo4j.graphalgo.EstimateEvaluator;
import org.neo4j.graphalgo.GraphAlgoFactory;
import org.neo4j.graphalgo.PathFinder;
import org.neo4j.graphalgo.WeightedPath;
import org.neo4j.graphdb.Direction;
import org.neo4j.graphdb.GraphDatabaseService;
import org.neo4j.graphdb.Node;
import org.neo4j.graphdb.PathExpander;
import org.neo4j.graphdb.PathExpanderBuilder;
import org.neo4j.graphdb.RelationshipType;
import org.neo4j.helpers.collection.Pair;
import org.neo4j.kernel.api.exceptions.InvalidArgumentsException;
import org.neo4j.procedure.Context;
import org.neo4j.procedure.Description;
import org.neo4j.procedure.Name;
import org.neo4j.procedure.Procedure;
import org.neo4j.procedure.TerminationGuard;
import org.neo4j.procedure.UserFunction;

import static org.neo4j.helpers.collection.MapUtil.map;
import static org.neo4j.procedure.Mode.READ;
import static org.neo4j.procedure.Mode.WRITE;

public class TrainingProcedures
{
    @Context
    public GraphDatabaseService db;

    @Context
    public TerminationGuard terminationGuard;

    @Description("Find movies by an actor")
    @Procedure(name = "training.moviesOnly", allowed = "movies_only", mode = READ)
    public Stream<Movie> moviesOnly( @Name("name") String name )
            throws InvalidArgumentsException, IOException
    {
        String query = "MATCH (:Person {name: {name}})-[:ACTED_IN]->(movie) RETURN movie";
        return db.execute( query, map( "name", name ) )
                .stream()
                .map( Movie::new );
    }


    @Procedure(name = "training.writeProcedure", mode = WRITE, allowed = "allowed_role")
    public Stream<StringResult> writeProcedure()
    {
        return db.execute( "CREATE (p:ProcCreated) RETURN labels(p) AS labels" ).stream().map(
                map -> new StringResult( ":" + ((List<?>) map.get( "labels" )).get( 0 ).toString() ) );
    }

    @Procedure(name = "training.waitFor", mode = READ, allowed = "allowed_role")
    public void waitFor(
            @Name(value = "duration", defaultValue = "1000ms") String durationText,
            @Name(value = "step", defaultValue = "500ms") String stepText )
    {
        waitForSpecifiedDuration(
                SimpleDurationParser.parseTextToMillis( durationText ),
                SimpleDurationParser.parseTextToMillis( stepText ) );
    }

    @UserFunction(name = "training.waitFor", allowed = "allowed_role")
    public long waitForFunction(
            @Name(value = "duration", defaultValue = "1000ms") String durationText,
            @Name(value = "step", defaultValue = "500ms") String stepText )
    {
        return waitForSpecifiedDuration(
                SimpleDurationParser.parseTextToMillis( durationText ),
                SimpleDurationParser.parseTextToMillis( stepText ) );
    }

    private long waitForSpecifiedDuration( double duration, double step )
    {
        long start = System.currentTimeMillis();
        long end = start;
        try
        {
            while ( end - start < duration )
            {
                Thread.sleep( (long) step );
                end = System.currentTimeMillis();
                terminationGuard.check();
            }
        }
        catch ( InterruptedException e )
        {
            e.printStackTrace();
        }
        return end - start;
    }

    public class StringResult
    {
        public final String value;

        public StringResult( String value )
        {
            this.value = value;
        }
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

