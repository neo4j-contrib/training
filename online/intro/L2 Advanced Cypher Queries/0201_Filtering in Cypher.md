# Filtering in Cypher

// Video: Filtering

----

Cypher provides us with a number of mechanisms for reducing the number of matching patterns returned in a result set. 

Let's start with a simple query:

     MATCH (n:Person)
     WHERE n.name = "Tom Hanks"
     RETURN n;

This will look through all of the nodes in the graph with a label of *Person* and if one of them has the name "Tom Hanks", it'll RETURN that node. 

There is a shorter version of this query, which adds the Properties to filter by to the MATCH clause.

     MATCH (n:Person {name:"Tom Hanks"})
     RETURN n;

--- 

Cypher Gadget: db: lesson1
