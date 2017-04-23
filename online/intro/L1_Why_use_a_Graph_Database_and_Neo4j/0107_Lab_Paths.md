# Lab: Paths

We've already seen how to RETURN all of the actors and directors in all of the movies:

     MATCH (a)-[:ACTED_IN]->(m)<-[:DIRECTED]->(d)
     RETURN a.name, m.title, d.name;

###How would you change this query to RETURN only the directors who acted in their own movies?###
The Cypher gadget will give you a few hints on how to proceed.

----

gadget: _lab_paths
{
  "message": "Lab: Find out which directors also acted in their movies, use what you've learned so far",
  "tasks": [
    {
      "check": "input",
      "test": ":ACTED_IN|:DIRECTED",
      "failMsg": "Your paths should contain both, the ACTED_IN and DIRECTED relationships."
    },
    {
      "check": "output",
      "test": "Clint Eastwood",
      "failMsg": "We expected someone else."
    }
  ]
}

** **
Hint: If you're having trouble, what would happen if you replaced the `(d)` and `d.name` with an `(a) ` and `a.name`? Does that work? Why? How could you simplify that query?

OK, and the answer is?

     MATCH (a)-[:ACTED_IN]->(m)<-[:DIRECTED]->(a)
     RETURN a.name;

This returns people who both acted and directed in the same movie and displays their name (the question didn't ask for what movies they'd acted and directed in).
