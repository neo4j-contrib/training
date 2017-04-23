# Advanced Lab: Aggregates: Count

##Recommend 3 actors that Keanu Reeves should work with (but hasn’t).##

This is kind of a *friends-of-a-friend* query, only that we don't have `FRIEND` relationships here but co-acting in a movie (`ACTS_IN`). So it might be a bit verbose in the first place. There are different approaches for the recommendation. So keep in mind that the top 3 most frequently appearing people in that network seem to be good candidates.

// console id=full

{
  "message": "Lab: Recommend 3 actors that Keanu Reeves should work with (but hasn't)",
  "tasks": [
    {
      "check": "input",
      "test": "Keanu Reeves",
      "failMsg": "You should look for Keanu Reeves"
    },
    {
      "check": "input",
      "test": ":ACTED_IN",
      "failMsg": "Your paths should use the ACTED_IN relationship several times"
    },
    {
      "check": "input",
      "test": "count",
      "failMsg": "You probably want to count the ocurrences"
    },
    {
      "check": "input",
      "test": "order by",
      "failMsg": "Ordering the results makes a lot of sense for top n"
    },
    {
      "check": "input",
      "test": "desc",
      "failMsg": "Remember to use the right sort order."
    },
    {
      "check": "input",
      "test": "limit 3",
      "failMsg": "You're still interested in the top 3, remember how to limit the output?"
    },
    {
      "check": "input",
      "test": "not",
      "failMsg": "Did you remember to exclude the ones he already worked with?"
    }
  ]
}

Solution

<pre style="color:transparent">
MATCH (keanu:Person)-[:ACTED_IN]->()<-[:ACTED_IN]-(c),
      (c)-[:ACTED_IN]->()<-[:ACTED_IN]-(coc)
WHERE keanu.name="Keanu Reeves"
  AND NOT((keanu)-[:ACTED_IN]->()<-[:ACTED_IN]-(coc))
  AND coc <> keanu
RETURN coc.name, count(coc)
ORDER BY count(coc) DESC
LIMIT 3; 
</pre>
End of Lab
**(Advanced Graph LAB) --> (Review of LESSON TWO) **