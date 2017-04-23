# Data Modeling in Neo4j

### Start with a Whiteboard
** **

One of the great things about Neo4j when compared to other database technologies is that you can get started with the modeling using a whiteboard. 

![Start with a Whiteboard](../images/slides_domain_01.jpeg)

An outline like the one above can easily be turned into a graph.

![](../images/slides_domain_02.jpeg)

### Model Incrementally

It's also important to model incrementally. You don't have to get all of the possible data into your model immediately. Start with a fairly simple model.

![](../images/slides_domain_03.jpeg)

You can then add refinement and more information to the model over time.

![](../images/slides_domain_04.jpeg)

### Provide Indexes for important entities

For entities in your model that are important enough to anchor your queries - in our case *Movies* and *People* it is recommended to create automatic indexes for.

Remember the syntax `CREATE INDEX ON :Label(property)`. For this model we would use:

* `CREATE INDEX ON :Movie(title)` 
* `CREATE INDEX ON :Person(name)` 

###Query Using Graph Patterns

However, unlike SQL, you don't want to just find all People where the column named *movie* equals 'Cloud Atlas' to find everyone having played in that movie.

Instead, you'd make sure there was a *Cloud Atlas* node, which has *:ACTED_IN* relationships from its cast. 
Then you could state a pattern that expresses the fact that people acted in a movie in your query: `(m:Movie)<-[:ACTED_IN]-(actor)` and also anchor it in the graph.

    MATCH (m:Movie)<-[:ACTED_IN]-(actor)
    WHERE m.title = "Cloud Atlas"
    RETURN actor;

an alternative notation:

    MATCH (m:Movie {title: 'Cloud Atlas'})<-[:ACTED_IN]-(actor)
    RETURN actor;

With the indexes mentioned above, Cypher would be clever enough to detect, that you are actually looking for a *:Movie* by its *title* property. As it knows there is an index for that combination it would use the index to quickly find the movie.

Without an index the query would still work but you require Cypher to scan all *Movie* nodes and compare their *title* property with the value you provided.