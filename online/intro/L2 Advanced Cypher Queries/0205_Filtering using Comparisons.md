# Filtering using Comparisons

We can also filter by comparing properties of different nodes. For example, we could      RETURN all of the actors who acted with *Tom Hanks* and are older than him:

    MATCH (tom:Person)-[:ACTED_IN]->()<-[:ACTED_IN]-(a:Person)
    WHERE tom.name="Tom Hanks"
    AND a.born < tom.born
    RETURN a.name;

Note that we didn't bother to put (movie) in the middle - just () as we don't need to know anything about the movie they worked together in.

We can even add a little math to the RETURN clause along with an alias to show us the difference in ages:

    MATCH (tom:Person)-[:ACTED_IN]->(movie),
    (a:Person)-[:ACTED_IN]->(movie)
    WHERE tom.name="Tom Hanks"
    AND a.born < tom.born
    RETURN DISTINCT a.name, (tom.born - a.born) AS diff;

Math can be used in both RETURN and WHERE expressions.

----

Try to do these and other computations now in the query window

// console id=lesson1

{
  "message": "All the actors who acted with Tom Hanks and are older than him.",
  "tasks": [
    {
      "check": "input",
      "test": ":Person",
      "failMsg": "You'll want to limit your nodes to ones labeled Person"
    },
    {
      "check": "input",
      "test": ":ACTED_IN",
      "failMsg": "Your paths should use the ACTED_IN relationship"
    },
    {
      "check": "input",
      "test": "\\.name",
      "failMsg": "You probably want to check the name property"
    },
    {
      "check": "input",
      "test": "Tom Hanks",
      "failMsg": "You wanted to look for Tom Hanks's colleagues"
    },
    {
      "check": "input",
      "test": "\\.born [<>]",
      "failMsg": "Compare the born (year) property"
    },
    {
      "check": "output",
      "results": "Jim Broadbent",
      "failMsg": "We expected someone else."
    }
  ]
}
