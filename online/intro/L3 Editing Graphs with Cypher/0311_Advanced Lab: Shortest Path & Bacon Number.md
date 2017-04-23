# Advanced Lab: Shortest Path and Bacon Number

### How would you find the Bacon number for Keanu Reeves? 

There is a function `shortestPath()` in Neo4j that can help you. It returns paths, much like a normal graph pattern in MATCH, just the shortest ones. You would use it like this:

       MATCH p=shortestPath( (node1)-[*]-(node2) ) 
       RETURN length(p), nodes(p)

So in our case, we have to find both *Keanu Reeves* and *Kevin Bacon* and use our *KNOWS* relationships to find the shortest paths between them.

       MATCH p=shortestPath( (keanu:Person)-[:KNOWS*]-(kevin:Person) ) 
       WHERE keanu.name="Keanu Reeves" and kevin.name = "Kevin Bacon"
       RETURN length(p)

Or in an alternative variant, where we find the two end-nodes first and then the shortest path:

    MATCH (keanu:Person {name:"Keanu Reeves"}), 
          (kevin:Person {name:"Kevin Bacon"})
    MATCH p=shortestPath((keanu)-[:KNOWS*]->(kevin))
    RETURN length(p);

### The next task is to return only the names of the people connecting Keanu and Kevin

We use one of our collection functions for this. For more details, see the [Cypher Reference card](http://docs.neo4j.org/refcard/2.0/) and the [Cypher Manual](http://docs.neo4j.org/chunked/stable/syntax-collections.html).

A path is a set of nodes interspersed with relationships. We can access the collection of nodes with `nodes(path)`. The collection function we want to use is `extract` which runs an expression on each element of a collection and returns that resulting value instead of the element. The syntax is: `extract( x in coll | expr )`

For example: 

* `extract(x in [1,2,3] | x*x)` to return the squares of a list, or
* `extract(n in nodes(path) | n.name)` to return the squares of a list
* a shorthand for extract is `[ x in coll | expr ] `

Let's give it a try:

    MATCH (keanu:Person {name:"Keanu Reeves"}), 
          (kevin:Person {name:"Kevin Bacon"})
    MATCH p=shortestPath((keanu)-[:KNOWS*]->(kevin))
    RETURN [ n in nodes(p) | n.name ];

Fold out the tabular result below to see all elements of the collection, i.e. all names on the path.

If you wanted to skip the first and last name, you could use a subscript on the collection like `[2..5]` or in our case `[1..-1]`, which means everything from the second to the before last element.

    MATCH (keanu:Person {name:"Keanu Reeves"}), 
          (kevin:Person {name:"Kevin Bacon"})
    MATCH p=shortestPath((keanu)-[:KNOWS*]->(kevin))
    RETURN [ n in nodes(p)[1..-1] | n.name ];


[id="lesson1-knows"]

