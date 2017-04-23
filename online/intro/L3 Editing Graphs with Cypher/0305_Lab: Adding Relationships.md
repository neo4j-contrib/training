# Adding Relationships

Can you add a director for the *Mystic River* Movie? *Clint Eastwood* directed the movie.
The relationship name is :DIRECTED) and no properties are required.

First of all we have to find both again, like in Kevin Bacon's case. That should be no problem. Try it. Now we have to create that simple DIRECTED relationship like we did before.

**Solution**

<pre style="color:transparent">     
    MATCH (clint:Person),(mystic:Movie)      
    WHERE clint.name="Clint Eastwood" AND mystic.title="Mystic River"
    CREATE (clint)-[:DIRECTED]->(mystic)
    RETURN clint, mystic;
</pre>

If you want to make sure that only **one** relationship is created, no matter how often you run this statement, use MERGE instead. 
`MERGE` has a *get-or-create* semantics. It tries to find the patterns you specify. If it finds them, it will return the data. Otherwise it creates the structure in the graph.

    MATCH (clint:Person),(mystic:Movie)      
    WHERE clint.name="Clint Eastwood" AND mystic.title="Mystic River"
    MERGE (clint)-[:DIRECTED]->(movie)
    RETURN clint, mystic;


[id="mystic-river-sean"]
