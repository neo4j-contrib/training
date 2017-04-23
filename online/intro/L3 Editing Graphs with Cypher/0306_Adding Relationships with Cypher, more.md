# Adding Relationships with Cypher, more

**Matching multiple relationships**

Now we try to create a KNOWS relationship between anyone who either ACTED_IN or DIRECTED the same movie. 

But let's find them first. We have to approach the movie from two sides (with both of these relationships) to find the two people to connect.

Hint: you're matching for a relationship of type types  `[:ACTED_IN|:DIRECTED]` - that pipe symbol handles the logical "or".

    MATCH (a)-[:ACTED_IN|:DIRECTED]->()<-[:ACTED_IN|:DIRECTED]-(b)
    RETURN a,b;

The next step is creating the *KNOWS* relationships. We don't want to have duplicate relationships, that's why we use MERGE instead of create.

    MATCH (a)-[:ACTED_IN|:DIRECTED]->()<-[:ACTED_IN|:DIRECTED]-(b)
    WHERE NOT (a)-[:KNOWS]-(b)
    MERGE (a)-[:KNOWS]->(b);

[id="lesson1"]

