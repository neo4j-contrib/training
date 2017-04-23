# Adding Properties with Cypher

To begin, let's add the movie *Mystic River* to the dataset.

    CREATE (movie:Movie {title: "Mystic River", released:1993}) 
    RETURN movie;

Let's say we wanted to add a *tagline* to the *Mystic River* movie node that  we added. 
First we have to locate the single movie again by its *title*, then SET the property. Here is the query:

    MATCH (movie:Movie)
    WHERE movie.title="Mystic River"
    SET movie.tagline = "We bury our sins here, Dave. We wash them clean."
    RETURN movie;

Because Neo4j is schema-free, you can add any property you want to any node or relationship.

What if you want to update a property? *Mystic River* was actually released in *2003*, not *1993*. We can fix that with the following query:

    MATCH (movie:Movie)
    WHERE movie.title="Mystic River"
    SET movie.released = 2003
    RETURN movie;

So you can see that the syntax is the same for updating or adding a property. You SET a property. If it exists, it'll update it. If not, it'll add it.

Your turn Movie-Database editor!

[id=lesson1,title="Adding 'Mystic River'"]

{
  "message": "Adding 'Mystic River'",
  "tasks": [
    {
      "check": "input",
      "test": ":Movie",
      "failMsg": "You probably want to use the :Movie label"
    },
    {
      "check": "input",
      "test": "title",
      "failMsg": "There should be a title property in your query"
    },
    {
      "check": "input",
      "test": "Mystic River",
      "failMsg": "This movie is titled 'Mystic River'"
    },
    {
      "check": "output",
      "test": "Mystic River",
      "failMsg": "It makes sense to return the movie too. For validation"
    }
  ]
}

