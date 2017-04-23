# Order, Limit and Skip

Ordering in Cypher
------------------
In Cypher it's easy to order results using a ORDER BY command like in SQL. Let's say we wanted to display the oldest actors, we could use the following query:

     MATCH (a:Person)-[ACTED_IN]->()
     RETURN a.name, a.born
     ORDER BY a.born 

The query returns every actor (it actually returns them once for every movie they acted in - we'll fix that later with a DISTINCT aggregation) ordered by their year of birth, so it'll display the oldest (smallest *a.born*) first.

Limit and Skip
--------------

Like some SQL databases, Neo4j supports easy pagination of record sets. It uses LIMIT and SKIP statements to reduce the number of records returned and to allow for paginating through the results. 

So it we wanted to display the *second page* of actors and movies they played in, we might use the following cypher query:

     MATCH (a)-[:ACTED_IN]->(m)
     RETURN a.name, m.title
     SKIP 10 
     LIMIT 10;

We could also just use LIMIT if we just want the top n-elements within a set. Want to see the names of the oldest 5 people in the system?

     MATCH (p:Person)
     RETURN p.name
     ORDER BY p.born
     LIMIT 5;

----

Try to to sort and limit some queries in the query window below.

// console db: lesson1
