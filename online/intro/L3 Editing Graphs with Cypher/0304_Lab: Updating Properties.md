# Lab: Updating properties

## Updating a relationship property

OK, let's try to change *Kevin Bacon*'s roles in *Mystic River* from ["Sean"] to ["Sean Devine"].

So we should find the *ACTED_IN* relationship between the two first using MATCH and then use SET to update the property as we learned when creating the movie.

[id="mystic-river-sean"]

### Solution

<pre style="color:transparent">
    MATCH (kevin)-[r:ACTED_IN]->(mystic) 
    WHERE kevin.name="Kevin Bacon" 
    AND mystic.title="Mystic River"
    SET r.roles = ["Sean Devine"]
    RETURN r;
</pre>

End of Section
**(LAB) -- (Editing the Graph: Update Property) --> (LAB) -- (Editing the Graph: Adding Relationships) **