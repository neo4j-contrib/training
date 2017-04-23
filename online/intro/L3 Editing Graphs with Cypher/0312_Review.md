# Review: Lesson 3

![Review: Lesson 3](https://vimeo.com/album/2584141/video/77867792)

So, to give some simple examples:

###Creating a node:

    CREATE (m:Movie {title:"Mystic River", released:1993});

###Creating a relationship:

    MATCH (movie:Movie {title:"Mystic River"),
          (kevin:Person {name:"Kevin Bacon"})
    MERGE (kevin)-[r:ACTED_IN]->(movie)
    ON CREATE SET r.roles=["Sean"]

###Adding a property to a node or relationship:

    MATCH (movie:Movie {title:"Mystic River"})
    SET movie.tagline = "We bury our sins here, Dave. We wash them clean."
    RETURN movie;

###Updating a property on a node or relationship:

    MATCH (movie:Movie {title:"Mystic River"})
    SET movie.released = 2003
    RETURN movie;

###Deleting a node:

    MATCH (emil:Person {name:"Emil Eifrem"})
    OPTIONAL MATCH (emil)-[r]-()
    DELETE emil, r;

**Note** that we're deleting any relationships as well. 
**You can't delete a node without first deleting its relationships (although you can do both in the same query).**

[id="full"]
