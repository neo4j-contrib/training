# Lab: All Characters in The Matrix

OK, now using the syntax we've learnt, RETURN a list all of the characters in the movie *The Matrix*

*Hint*: Movies have the label *Movie* and a *title* property you want to compare to
*Hint*: We're looking for the characters (the *roles* which are a property of the *ACTED_IN* relationships) - not the names of the actors.



// console id: lesson1

{
  "message": "Lab: All Characters in the Matrix",
  "tasks": [
    {
      "check": "input",
      "test": ":Movie",
      "failMsg": "You'll want to limit your nodes to ones labeled Movie"
    },
    {
      "check": "input",
      "test": "\\.title",
      "failMsg": "You probably want to check the title property"
    },
    {
      "check": "input",
      "test": "The Matrix",
      "failMsg": "You wanted to look for the movie titled 'The Matrix'"
    },
    {
      "check": "input",
      "test": ":ACTED_IN",
      "failMsg": "Your paths should use the ACTED_IN relationship"
    },
    {
      "check": "input",
      "test": "\\w+:ACTED_IN",
      "failMsg": "You probably wanted to assign an identifier to your relationship"
    },
    {
      "check": "input",
      "test": "\\.roles",
      "failMsg": "You wanted to RETURN the roles property of the relationship"
    },
    {
      "check": "output",
      "results": "Neo",
      "failMsg": "We expected some other characters"
    }
  ]
}

<!--
Solution:

    MATCH (actor)-[r:ACTED_IN]->(movie:Movie)
    WHERE movie.title = "The Matrix"
    RETURN r.roles;
-->

If you see all the usual suspects, you're good. If not, let's fix that next.