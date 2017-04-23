# Aggregation

###Cypher offers aggregation mechanisms, similar to, but better than SQL’s GROUP BY.

![Aggregates](https://vimeo.com/77868060)

** **
Like SQL, Cypher provides support for a number of aggregate functions:
 
`count(x)` Count the number of occurrences
`min(x)` Get the lowest value
`max(x)` Get the highest value
`avg(x)` Get the average of a numeric value
`sum(x)` Sum up values
`collect(x)` Collect all the values into an collection

More on aggregate functions can be found in the [Neo4j Manual](http://docs.neo4j.org/chunked/2.0.0/query-aggregation.html#_statistics)

Here's an example of using aggregates to get a list of all of the movies that an actor acted in:


![Finding Filmographies](https://vimeo.com/77872043)

###Collect

Let's say we wanted to display all movie titles that an actor participated in, aka the filmography. We could use the following query:

     MATCH (a:Person)-[:ACTED_IN]->(m)
     RETURN a.name, collect(m.title);

For every *Person* who has acted in at least one movie, the query will RETURN their name and an array of strings containing the movie titles.

Let's look closer at the graph and at Tom Hanks' movies.

![Actors and Directors]()

** ** 
Here are some more examples.

How would you RETURN all director names that each actor has ever worked with?

**Solution**

    MATCH (a:Person)-[:ACTED_IN]->(m)<-[:DIRECTED]-(d)
    RETURN a.name, collect(d.name);

###Count

Let's say we wanted to RETURN the number of movies that an actor had acted in. What would that query look like?

**Solution**

    MATCH (a:Person)-[:ACTED_IN]->(m)
    RETURN a.name, count(m);

### Top-n

Oftentimes you're interested in the top-n results, which result from a `count` aggregation. This is achieved by counting first and the ordering the results in a `DESC`ending manner and then `LIMIT`ing the results by the top n. If we would be interested in the top ten actors, who acted in the most movies, the query would look like this.

    MATCH (a:Person)-[:ACTED_IN]->(m)
    RETURN a.name, count(m)
    ORDER BY count(m) DESC
    LIMIT 10;


What about the number of films that an actor and director have jointly worked in?

**Solution**

    MATCH (a:Person)-[:ACTED_IN]->(m)<-[:DIRECTED]-(d)
    RETURN a.name, d.name, count(m);

// console id: _lab_paths

{
  "message": "Aggregation",
  "tasks": [
    {
      "check": "input",
      "test": ":Person",
      "failMsg": "You'll want to start at nodes labeled Person"
    },
    {
      "check": "input",
      "test": ":ACTED_IN",
      "failMsg": "Your paths should use the ACTED_IN relationship"
    },
    {
      "check": "input",
      "test": "(collect|count|avg|min|max)",
      "failMsg": "You certainly wanted to use an aggregation function"
    }
  ]
}

