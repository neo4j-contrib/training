# Filtering using Patterns

###What if we want to see the actor *Gene Hackman*?
    
     MATCH (gene:Person)
     WHERE gene.name="Gene Hackman"
     RETURN gene;

or the concise alternative syntax 

     MATCH (gene:Person {name:"Gene Hackman"})
     RETURN gene;

###How would we find all the actors who worked with *Gene*?
     
    MATCH (gene:Person)-[:ACTED_IN]->()<-[:ACTED_IN]-(other)
    WHERE gene.name="Gene Hackman"
    RETURN DISTINCT other;

###Now, how do we filter those actors to get the ones that also directed their own movies?
     
    MATCH (gene:Person)-[:ACTED_IN]->(m),
    (other)-[:ACTED_IN]->(m)
    WHERE gene.name="Gene Hackman"
    AND   (other)-[:DIRECTED]->()
    RETURN DISTINCT other;
** **
###Here's a more complex example - actors who worked with *Keanu Reeves*, but not when he was also working with *Robin Williams*.

    MATCH (keanu:Person {name:"Keanu Reeves"})-[:ACTED_IN]->(movie),
          (other)-[:ACTED_IN]->(movie), 
          (robin:Person {name:"Robin Williams"})
    WHERE NOT (robin)-[:ACTED_IN]->(movie)
    RETURN DISTINCT other;

This small dataset doesn't represent reality, but do run the queries against it anyway.

// console id: _lab_paths