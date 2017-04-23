# Getting Started with Cypher

// Video Getting Started with Cypher


###Cypher is Neo4j's Graph Query Language

Cypher is a declarative, SQL inspired language for describing patterns in graphs. It allows us to describe *what* we want to select, insert, update or delete from a graph database without requiring us to describe exactly *how* to do it.


![](../images/cypher_pattern_simple.png)

** **
###Nodes
Cypher uses <a href="http://en.wikipedia.org/wiki/ASCII_art" target="_blank">ASCII-art</a> to represent patterns. We surround nodes with parentheses which look like circles, e.g. `(node)`. If we later want to refer to the node, we'll give it an identifier like `(a)` for actor or `(m)` for movie. In real world queries, we'll probably use longer, more expressive variable names like `(actor)` or `(movie)`.
<!--
 If we don't care about the actual node, just its existence, we can just represent it with empty parentheses - `()`.
-->
So for example, if we want to find all the *actors* and the *movies* they have acted in, the query will include the identifiers *actor* and *movie*, e.g. in a pattern like `(actor)-->(movie)` so we can refer to them later, e.g. to access properties like `actor.name` and `movie.title`. 
<!--
If I only care about the actors and not the movies they acted in, my query would include something like `(actor)--&gt;()`.
-->

The more general structure is:

    MATCH (node) RETURN node.property

    MATCH (node1)-->(node2) 
    RETURN node2.propertyA, node2.propertyB

###Relationships
The problem with the Cypher snippets we saw above is that they didn't say anything about the relationship between the nodes, so even though we used the identifier *actor*, we may well have gotten back *directors* and *producers* of our *movies*. So we need to be able to describe the types of relationships in our Cypher queries.

If we wanted to retrieve everyone who had acted in a movie, we would describe the pattern `(actor)-[:ACTED_IN]->(movie)` to retrieve only nodes that had a relationship typed *ACTED_IN* with other nodes (*movies*) those nodes would the be *actors* as implied by the *ACTED_IN* relationship.

Or generally:

    MATCH (node1)-[:REL_TYPE]->(node2)

Sometimes we need access to information about a relationship (e.g. its type or properties). For example, we might want to output the *roles* that an *actor* played in a *movie* and that *roles* would probably be a property of the *role* relationship. As with nodes, we can use identifiers for relationships (in front of the *:TYPE*). If we tried to match `(actor)-[role:ACTED_IN]->(movie)` we would be able to output the `role.roles` for each of the actors in all of the movies that they acted in.

    MATCH (node1)-[rel:TYPE]->(node2) 
    RETURN rel.property

###Labels
Labels allow us to group our nodes. For example, we might want to distinguish *movies* from *people* or animals (both act in films). By matching for `(actor:Person)-[:ACTED_IN]->(movie)`, it will return *Clint Eastwood*, but not *Clyde* - his pet orangutan in *Every Which Way but Loose*. Let's leave arguments over which of the two should get the most credit as an actor to film buffs!

Labels are usually used like this:

    MATCH (node:Label) RETURN node

    MATCH (node1:Label1)-[:REL_TYPE]->(node2:Label2) 
    RETURN node1, node2

To recap this all visually, we tried to map the actors and movies domain model to a concrete query that finds all *actors*  *names* and their *roles* in the *movie* "The Matrix".


// slideshow domain model evolution // todo replace by series of pictures

![](../images/slides_domain_01.jpeg)
![](../images/slides_domain_02.jpeg)
![](../images/slides_domain_03.jpeg)
![](../images/slides_domain_04.jpeg)


Let's now map the query for **Find all Characters in the Movie "The Matrix"** to the concepts we've seen so far: 

* Nodes 
* Relationships
* Properties
* Relationship-Types
* Labels
* Identifiers

And we do it step by step, to keep things simple.