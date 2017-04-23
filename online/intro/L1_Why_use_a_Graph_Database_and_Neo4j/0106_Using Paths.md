# Using Paths

In addition to being able to match paths, we can name paths and RETURN them as part of the result. So we could take a version of the last query we used and name the entire path, returning that:

     MATCH p=(a)-[:ACTED_IN]->(m)<-[:DIRECTED]-(d)
     RETURN p;

This will RETURN all of the nodes and relationships for each path - including all of their properties. That's interesting, but can be too much data, so we might use the nodes() function just to RETURN the nodes in the path:

     MATCH p=(a)-[:ACTED_IN]->(m)<-[:DIRECTED]-(d)
     RETURN nodes(p);

There is a similar function for relationships:

     MATCH p=(a)-[:ACTED_IN]->(m)<-[:DIRECTED]-(d)
     RETURN rels(p);

Note that only connected patterns can be used to create named paths. If you have two patterns in your MATCH clause with a comma between them, you'd have to RETURN the results as two separate named paths:

     MATCH p1=(a)-[:ACTED_IN]->(m), p2=(d)-[:DIRECTED]->(m)
     RETURN p1, p2;
----


// gadget db: lesson1 

{
  "message": "Adding patterns to paths",
  "tasks": [
    {
      "check": "input",
      "test": ":ACTED_IN|:DIRECTED",
      "failMsg": "Your paths should contain both, the ACTED_IN and DIRECTED relationships."
    },
    {
      "check": "input",
      "test": "p.?\\s*=",
      "failMsg": "You should assign the path expression to a path 'p' or 'p1'"
    }
  ]
}