So far we've just been looking at partial snippets of Cypher. 
*Now let's look at some simple, but complete Cypher queries.*


// Video 
![](https://vimeo.com/77866847)

## Some Simple Queries

Please make an effort and try these queries in the Cypher widget below. Try not to copy and paste them, but instead understand and **write them on your own**.

###All Nodes Query
If we wanted to return every single node in the graph, we can use the following query:

    MATCH (n)
    RETURN n;

The query is doing a full graph search. It visits every single node to see whether it matches the pattern of `(n)`. In this concrete case, the pattern is simply a node that may or may not have relationships, so it will match every single node in the graph. The `RETURN ` clause then returns all of the information about each of those nodes - including all of their properties. 

Note the semicolon after the RETURN clause. It is used to tell the **Neo4j-Shell** that you're finished writing your query. In the command line Neo4j-Shell - if you don't use a semicolon, Neo4j will assume you still have more to write and will sit patiently waiting for the rest of your input. In both the **Cypher gadget** in this course and the **Neo4j Browser** it is not needed and silently ignored.

-----

###Two Nodes, One Relationship
Let's say we wanted to return all of the nodes that have relationships to another node. This is still going to return every single node that has a relationship to another node - along with the other node. But it's moving us in an important direction, so stay with us for a little longer!

To describe this query, we'd write:

    MATCH (n)-->(m) 
    RETURN n, m;


This will return every pair of nodes with a relationship going from *n* to *m*.

----

###Not Everything Needs a Name
If we only want to return the nodes that have **a relationship** with some another node, but don't care at all about that other node, we can write a query that just refers to the starting nodes by removing the identifiers for the second node from the query:

    MATCH (n)-->( )
    RETURN n;

It's important to note that we removed *m* from the RETURN clause as well as the MATCH clause.

----

###Returning a Property

Most of the time, we don't want to return an entire node - we just want some information about it. If we wanted to just return the *name* for a set of nodes, the following query would allow us to do that:

    MATCH (person)-->()
    RETURN person.name;

In our dataset this makes sense, because people (with a *name* property) have relationships **TO** movies. Otherwise we would get a lot of NULL values returned.

More generally:

    MATCH (node)-->()
    RETURN node.property;


Note that we can use whatever identifier we like and makes sense for us in the context of our query. It doesn't matter to Cypher if we name the nodes in our query *a*,*n*,*m* or *person*. Just make sure that it readable and understandable for a human.

----

###Referring to a Relationship
There are two data integrity constraints in Neo4j. 

1. A relationship must have a start node and an end node (yes, they can be the same node). So there are no dangling relationships or broken links.
2. Every relationship must have a type. 

We can assign an identifier to a relationship and then return the properties or the type of the relationship.

    MATCH (node)-[rel]-> ()
    RETURN node, rel.property;

    MATCH (node)-[rel]-> ()
    RETURN node, type(rel);

In our movie graph:

    MATCH (person)-[rel]->(movie)
    RETURN person, type(rel)

By convention those relationship-types are written all upper case using underscores between words, so results in a movie graph might be *DIRECTED*, *ACTED_IN* and *PRODUCED*. 

----

###Match by Node Label

Oftentimes we don't want to visit *all* the nodes in a graph to match patterns - it's too inefficient. A first step to improving efficiency is to limit the set to look at by using **Labels**. The following query allows us to return everyone who *acted in* a movie, but it'll only look for *people*, so (a) it won't include orangutang actors, and (b) it won't look directly at *movies* or any other nodes for the starting point of the matching patterns. This will make the query much more efficient:

    MATCH (actor:Person)-[:ACTED_IN]->(movie)
    RETURN actor.name, movie.title;

And if we wanted to find a specific person using a label - only nodes with a label *Person* - we could combine that with a property constraint in WHERE to find *Tom Hanks*:

    MATCH (tom:Person)
    WHERE tom.name = "Tom Hanks"
    RETURN tom;

Note that we're still visiting all of the *people* in the graph, but we're **not** also visiting all of the movies and other nodes.

There is also a shorter syntax for finding nodes by the value of a few properties:

    MATCH (tom:Person {name:"Tom Hanks"})
    RETURN tom;

----

// Cypher Gadget: db: lesson1

{
  "message": "Run the simple queries you've just learned",
  "tasks": [
    {
      "check": "input",
      "test": "match.+return",
      "failMsg": "Your query should contain at least a MATCH and RETURN clause"
    }
  ]
}


----

###The Cypher query language is comprised of several distinct clauses.###

#### Querying the graph
**MATCH**: Matches the given graph pattern in the graph data.
**WHERE**: Filters using predicates or anchors pattern elements.
**RETURN**: Returns and projects result data, also handles aggregation.
**ORDER BY**: Sorts the query result.
**SKIP/LIMIT**: Paginates the query result.

#### Updating the graph
**CREATE**: Creates nodes and relationships.
**MERGE**: Creates nodes uniquely.
**CREATE UNIQUE**: Creates relationships uniquely.
**DELETE**: Removes nodes, relationships.
**SET**: Updates properties and labels.
**REMOVE**: Removes properties and labels.
**FOREACH**: Performs updating actions once per element in a list.
**WITH**: Divides a query into multiple, distinct parts and passes results from one to the next.
** **


So far we've only dealt with simple patterns. Let's now look at how Cypher works with longer paths.

 ** **
End of Section
**(Your First Cypher Queries) --> (Paths in Cypher)**
