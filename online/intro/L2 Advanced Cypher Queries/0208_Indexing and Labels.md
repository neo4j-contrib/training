# Indexing and Labels

https://vimeo.com/album/2584141/video/77867851

Like any other database, Neo4j will perform better if you add indexes. Often you'll create a *label specific index* as indexes are usually only relevant to certain kinds of nodes.

So, if you want to be able to search efficiently for *Movies* based on their *title*, you might run the following cypher command:

    CREATE INDEX ON :Movie(title);

How would you create an index for searching people by name?

**Solution**
    
    CREATE INDEX ON :Person(name);

And you don't need to do anything to your queries to use these indexes. If you run the commands above, and you run a query like:

    MATCH (gene:Person)-[:ACTED_IN]->(m),
     (other)-[:ACTED_IN]->(m)
    WHERE gene.name="Gene Hackman"
    RETURN DISTINCT other;

The lookup of Gene Hackman will now be much faster - although with a small test data set the difference may not be noticeable.

Try to use the query once with and without an index

// console id=full


### Create a Label specific Index
````
    CREATE INDEX ON :Person(name);
````
* nodes labeled as Person, indexed by name property

````
    CREATE INDEX ON :Movie(title);
````
* nodes labeled as Movie, indexed by title property


## Anchor pattern nodes in the graph

###Movies featuring both Tom Hanks and Kevin Bacon
    MATCH (tom:Person)-[:ACTED_IN]->(movie),
          (kevin:Person)-[:ACTED_IN]->(movie)
    WHERE tom.name="Tom Hanks" AND
          kevin.name="Kevin Bacon"
    RETURN DISTINCT movie;

You can anchor one or more nodes of your pattern in the graph. E.g. by constraining their properties to a single fitting node. Then the pattern matching works much faster as Cypher doesn't has to scan the whole graph to apply the patterns.

## Now it's your turn to create indexes and run this query!

// console id = full

