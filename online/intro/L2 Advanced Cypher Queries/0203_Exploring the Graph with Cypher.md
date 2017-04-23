# Exploring the Graph with Cypher

In this video, we'll learn how you can explore an unknown graph easily using Cypher to gather some insight about the structure of the data:

![Exploring the Graph with Cypher]()

In general, labels often give good insight into the types of nodes in a graph. From there you can return sample datasets to learn about properties and relationships usually attached to these nodes.

### Distinct Results

Often you find yourself wanting to return only the distinct results for a query. For example, let's look at the list of the oldest 5 actors. Initially we might try the following:

    MATCH (a)-[:ACTED_IN]->()
    RETURN a
    ORDER BY a.born
    LIMIT 5

But if any of the five oldest actors were in more than one film we'll get them multiple times. So the query we really want to run is:

    MATCH (a)-[:ACTED_IN]->()
    RETURN DISTINCT a
    ORDER BY a.born
    LIMIT 5
    
### Learning about "People" using Cypher

Now that we have the DISTINCT command, let's find out a little more about the people in the system by querying the various relationships of the nodes with a *Person* label attached to them.

// Video Learn about Person nodes

----

Now let's put it all together, you've learned about patterns, a bit about labels and about filtering.
So we should be able to answer these questions.

**Movies in which Tom Hanks acted, that were released after 2000 **

    MATCH (tom:Person {name:"Tom Hanks")-[:ACTED_IN]->(movie:Movie)
    WHERE  movie.released > 2000
    RETURN movie.title;

**Movies in which Keanu Reeves played Neo**

    MATCH (actor:Person {name:"Keanu Reeves"})-[r:ACTED_IN]->(movie)
    WHERE AND "Neo" IN r.roles
    RETURN movie.title;

### Syntax Guide
    {expression} IN {collection}
Checks for the existence of the value of `{expression}` in the `{collection}`

Run these more complex queries, try to vary conditions and see what happens.

// console[id=lesson1]
