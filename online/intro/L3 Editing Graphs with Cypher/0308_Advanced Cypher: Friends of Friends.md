# Advanced Cypher: Friends of Friends

In Cypher, we can describe variable length paths using a star: `*`

    MATCH (node1)-[*]-(node2)

![Variable Lenght Paths](../images/varlength_paths.png)

If you want to traverse relationships up to four levels deep it'd be `(a)-[*1..4]->(b)`

If you want to traverse any depth it's simply `(a)-[*]->(b)`

For a specific depth of relationships it's `(a)-[*3]->(b)` to find all connections exactly three relationships away.

And of course, you can constrain by the type of relationships, so for friends of friends you would use `[:FRIENDS*2]` if there were FRIENDS relationships.
