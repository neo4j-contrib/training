#Lab: Friends of Friends

** **
1. Try to `RETURN` all Keanu Reeve's friends of friends (using the KNOWS relationships) that we created earlier.

2. How would you refine this to get friends of friends who are not his immediate friends?


[id="lesson1-knows"]

**Solution 1**

<pre style="color:transparent">
    MATCH (keanu:Person)-[:KNOWS*2]->(fof)
    WHERE keanu.name = "Keanu Reeves"
    RETURN DISTINCT fof.name;
</pre>

**Solution 2**

<pre style="color:transparent">
    MATCH (keanu:Person)-[:KNOWS*2]->(fof)
    WHERE keanu.name = "Keanu Reeves"
    AND NOT((keanu)-[:KNOWS]-(fof))
    RETURN DISTINCT fof.name;
</pre>
** **
End of Section
**(Graph LAB) --> (Advanced Graph LAB)**