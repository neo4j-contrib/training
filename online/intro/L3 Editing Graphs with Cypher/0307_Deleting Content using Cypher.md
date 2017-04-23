# Deleting Content using Cypher

Previously, we'd added ourselves to the graph. If you didn't do that, add yourself now using the following query (replacing "My Name" with your name):

    CREATE (me:Person {name: "My Name"});

Let's then run the following query to make sure you have been added successfully to the graph.

    MATCH (p:Person {name:"My Name"})
    RETURN p.name;

Great, now let's see in the following video how to remove a node from the graph.

![Remove Yourself](https://vimeo.com/77868212)

***
So, to remove both yourself and any relationships you might or might not have, you need to run:

    MATCH (me:Person {name="My Name"})
    OPTIONAL MATCH (me)-[r]-()
    DELETE me,r;

It turns out there is another node in the graph that also needs to be deleted. Run the following query:

    MATCH (matrix:Movie {title:"The Matrix"})<-[r:ACTED_IN]-(actor)
    RETURN actor.name, r.roles;

It's looking for actors who played in the Matrix and returning them. 
But wait, there *wasn't* an Emil in the Matrix. So we need to delete this person.

Go ahead and delete Emil.

[id="full"]

Did it work? No? Then go ahead, check out the next section.


