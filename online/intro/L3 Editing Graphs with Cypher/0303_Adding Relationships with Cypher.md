# Adding Relationships with Cypher

In the following video we query reviews to see the format they should take and then add a review of "The Matrix".

![Review the Reviewers](https://vimeo.com/77868214)

So, adding a relationship is similar to adding a node, but we CREATE the relationship with the *relationship-syntax*  `(n)-[:REL_TYPE {prop: value}]->(m)`:

Let's create ourselves first in this new database:

    CREATE (me:Person {name:"My Name"});

And then let's rate the movie Mystic River (or any other movie that you want to rate).

    MATCH (me:User), (movie:Movie)      
    WHERE me.name="My Name" AND 
          movie.title="Mystic River"
    CREATE (me)-[:REVIEWED {rating:80, summary:"tragic character movie"}]->(movie);

### Lab: Add *Kevin Bacon* as an actor to *Mystic River*

Now you should add *Kevin Bacon* as an actor with an *ACTED_IN* relationship with *roles* of *["Sean"]*  (it is an array, but the SET syntax is unchanged) to the movie *Mystic River*.

**Solution**

<pre style="color:transparent">
     MATCH (movie:Movie),(kevin:Person)
     WHERE movie.title="Mystic River" AND
           kevin.name="Kevin Bacon"
     CREATE UNIQUE (kevin)-[:ACTED_IN {roles:["Sean"]}]->(movie)
</pre>

What about adding properties to nodes or relationships that already exist? Let's see in the next lesson.

[id="mystic-river"]
