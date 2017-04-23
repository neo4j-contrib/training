//mount gadgets with respective tasks, first two are examples
$(function() {
      //Example 1:
      renderGadget('#ex1', {
        label: "Try it out: See an example widget",
        cypherSetup: "lesson1",
        task: {
          message: "Adding 'Mystic River'",
          tasks: [{
            "check": "input",
            "test": ":Movie",
            "failMsg": "You probably want to use the :Movie label"
          }, {
            "check": "input",
            "test": "title",
            "failMsg": "There should be a title property in your query"
          }, {
            "check": "input",
            "test": "Mystic River",
            "failMsg": "This movie is titled 'Mystic River'"
          }, {
            "check": "output",
            "test": "Mystic River",
            "failMsg": "It makes sense to return the movie too. For validation"
          }]
        }
      });

      //TODO-WIDGET
      renderGadget('#outputRoles', {
        label: "Try it out: Output roles for each actor",
        cypherSetup: "lesson1",
        task: {
          message: "Output the roles for each movie an actor acted in.",
          tasks: [],
          description:"<atch <code>(actor)-[rel:ACTED_IN]->(movie)</code> and output the <code>rel.roles</code> for each of the actors",
          solution:`MATCH (actor:Person)-[rel:ACTED_IN]->(movie:Movie)
RETURN rel.roles`,
        }
      });
      //TODO-WIDGET
      renderGadget('#addRelationshipKevinMystic', {
        label: "Try it out: Add the ACTED_IN relationship between Kevin and Mystic River",
        cypherSetup: "mystic-river",
        task: {
          message: "Add the ACTED_IN relationship between Kevin and Mystic River.",
          tasks: [],
          description:"Find the actor <code>Kevin Bacon</code> and the movie <code>Mystic River</code> and add the relationship between the movie and the actor to the dataset.",
          solution:`MATCH (kevin:Person) WHERE kevin.name = "Kevin Bacon"
MATCH (mystic:Movie) WHERE mystic.title = "Mystic River"
CREATE (kevin)-[r:ACTED_IN {roles:["Sean"]}]->(mystic)
RETURN mystic,r, kevin`,
        }
      });
      //TODO-WIDGET
      renderGadget('#updateRelationshipProperty', {
        label: "Try it out: Update relationship properties",
        cypherSetup: "mystic-river",
        task: {
          message: "Update the relationship property.",
          tasks: [],
        description: `Lets change the role of <strong>Kevin Bacon</strong> in <strong>Mystic River</strong> from <code>["Sean"]</code> to <code>["Sean Devine"]</code>. 
 We should find the <code>ACTED_IN</code> relationship between the <code>Person</code> and <code>Movie</code> using <code>MATCH</code> and then use <code>SET</code> 
 to update the relationship <code>roles</code> property as we learned when creating the <code>Movie</code> node.`,
        solution: 
`MATCH (kevin:Person)-[r:ACTED_IN]->(mystic:Movie) 
WHERE kevin.name="Kevin Bacon" AND mystic.title="Mystic River" 
SET r.roles = ["Sean Devine"] 
RETURN r.roles`,
        }
      });
      //TODO-WIDGET
      renderGadget('#reviewMovie', {
        label: "Try it out: Add a rating and a review to a movie",
        cypherSetup: "mystic-river",
        task: {
          message: "Add a rating and a review to a movie.",
          tasks: [],
          description:"Rate the <code>Movie</code> <code>Mystic River</code>.",
          solution:`MATCH (me:Person {name:"My Name"}),(movie:Movie {title:"Mystic River"})
CREATE (me)-[r:REVIEWED {rating:80, summary:"tragic character movie"}]->(movie)
RETURN me, r, movie`,
        }
      });
      //TODO-WIDGET
      renderGadget('#addClintDirector', {
        label: "Try it out: Add Clint Eastwood as director.",
        cypherSetup: "mystic-river",
        task: {
          message: "Add Clint Eastwood as director.",
          tasks: [],
          description:``,
          solution:``,
        }
      });
      //TODO-WIDGET
      renderGadget('#createClintDirector', {
        label: "Try it out: CREATE Clint Eastwood as director.",
        cypherSetup: "mystic-river",
        task: {
          message: "CREATE Clint Eastwood as director.",
          tasks: [],
          description:"Add a director for the movie <code>Mystic River</code>. <code>Clint Eastwood</code> <code>DIRECTED</code> <code>Mystic River</code>.",
          solution:`MATCH (clint:Person),(mystic:Movie)
WHERE clint.name="Clint Eastwood" AND mystic.title="Mystic River"
CREATE (clint)-[r:DIRECTED]->(mystic)
RETURN clint,r,mystic`,
        }
      });
      //TODO-WIDGET
      renderGadget('#mergeClintDirector', {
        label: "Try it out: MERGE Clint Eastwood as director.",
        cypherSetup: "mystic-river",
        task: {
          message: "MERGE Clint Eastwood as director.",
          tasks: [],
          description:``,
          solution:`MATCH (clint:Person),(mystic:Movie)
WHERE clint.name="Clint Eastwood" AND mystic.title="Mystic River"
MERGE (clint)-[:DIRECTED]->(mystic)
RETURN clint, mystic`,
        }
      });
      //TODO-WIDGET
      renderGadget('#actorsInTheMatrix', {
        label: "Try it out: Display the actors in The Matrix",
        cypherSetup: "lesson1",
        task: {
          message: "",
          tasks: [],
          description:"Display the actors in The Matrix",
          solution:`MATCH (matrix:Movie {title:"The Matrix"})<-[r:ACTED_IN]-(actor)
RETURN actor.name, r.roles`,
        }
      });
      //TODO-WIDGET
      renderGadget('#deleteEmilFail', {
        label: "Try it out: Delete Emil.",
        cypherSetup: "lesson1",
        task: {
          message: "Try to delete Emil",
          tasks: [],
          description:``,
          solution:`MATCH (emil:Person {name:"Emil Eifrem"})
DELETE emil`,
        }
      });
      //TODO-WIDGET
      renderGadget('#tryLabels', {
        label: "Try it out: Try some queries using Labels",
        cypherSetup: "lesson1",
        task: {
          message: "Try some queries using Labels.",
          tasks: [],
          description:``,
          solution:``,
        }
      });
      //TODO-WIDGET
      renderGadget('#oldestActors', {
        label: "Try it out: Find the oldest actors.",
        cypherSetup: "lesson1",
        task: {
          message: "Find the oldest actors.",
          tasks: [],
          description:"Find the oldest actors in this dataset without any repeats.",
          solution:`MATCH (actor:Person)-[:ACTED_IN]->()
RETURN DISTINCT actor
ORDER BY actor.born
LIMIT 5`,
        }
      });
      renderGadget('#default', {
        label: "Try it out!",
        cypherSetup: "lesson1",
        task: {
          message: "Try it out!",
          tasks: [],
          description:``,
          solution:``,
        }
      });

      renderGadget('#default2', {
        label: "Try it out!",
        cypherSetup: "lesson1",
        task: {
          message: "Try it out!",
          tasks: [],
          description:``,
          solution:``,
        }
      });

      renderGadget('#addingMysticRiver', {
        label: "Try it out: Adding 'Mystic River'",
        cypherSetup: "lesson1",
        task: {
          message: "Adding 'Mystic River'",
          tasks: [{
            "check": "input",
            "test": ":Movie",
            "failMsg": "You probably want to use the :Movie label"
          }, {
            "check": "input",
            "test": "title",
            "failMsg": "There should be a title property in your query"
          }, {
            "check": "input",
            "test": "Mystic River",
            "failMsg": "This movie is titled 'Mystic River'"
          }, {
            "check": "output",
            "test": "Mystic River",
            "failMsg": "It makes sense to return the movie too. For validation"
          }]
        }
      });

      renderGadget('#deleteEmil', {
        label: "Try it out: Delete Emil and his relationships",
        cypherSetup: "lesson1",
        task: {
          message: "Delete Emil and his relationships",
          tasks: [{
            "check": "input",
            "test": ":Person",
            "failMsg": "You'll want to start at nodes labeled Person"
          }, {
            "check": "input",
            "test": "name.+Emil Eifrem",
            "failMsg": "You probably want to check the name property for 'Emil Eifrem'"
          }, {
            "check": "input",
            "test": "DELETE",
            "failMsg": "You most probably want to DELETE Emil and his relationships"
          }],
          solution:`MATCH (emil:Person {name:"Emil Eifrem"})
DETACH DELETE emil`
        }
      });

      renderGadget('#matchByNodeLabel', {
        label: "Try it out: Match by node label",
        cypherSetup: "lesson1",
        task: {
          message: "Run the simple queries you've just learned",
          tasks: [{
            "check": "input",
            "test": "match.+return",
            "failMsg": "Your query should contain at least a MATCH and RETURN clause"
          }]
        }
      });

      renderGadget('#allCharactersMatrix', {
        label: "Try it out: Lab: All Characters in the Matrix",
        cypherSetup: "lesson1",
        task: {
          message: "Lab: All Characters in the Matrix",
          description: "<code>RETURN</code> a list of all the characters in <code>The Matrix</code>",
          solution: `MATCH (actor:Person)-[r:ACTED_IN]->(movie:Movie)
WHERE movie.title = "The Matrix"
RETURN actor.name AS Actor, r.roles AS Roles`,
          tasks: [{
            "check": "input",
            "test": ":Movie",
            "failMsg": "You'll want to limit your nodes to ones labeled Movie"
          }, {
            "check": "input",
            "test": "(\\.title|title:)",
            "failMsg": "You probably want to check the title property"
          }, {
            "check": "input",
            "test": "The Matrix",
            "failMsg": "You wanted to look for the movie titled 'The Matrix'"
          }, {
            "check": "input",
            "test": ":ACTED_IN",
            "failMsg": "Your paths should use the ACTED_IN relationship"
          }, {
            "check": "input",
            "test": "\\w+:ACTED_IN",
            "failMsg": "You probably wanted to assign an identifier to your relationship"
          }, {
            "check": "input",
            "test": "\\.roles",
            "failMsg": "You wanted to RETURN the roles property of the relationship"
          }, {
            "check": "output",
            "results": "Neo",
            "failMsg": "We expected some other characters"
          }]
        }
      });

      renderGadget('#allCharactersActedWithAndOlderThanTom', {
        label: "Try it out: All the actors who acted with Tom Hanks and are older than him.",
        cypherSetup: "full",
        task: {
          message: "All the actors who acted with Tom Hanks and are older than him.",
          tasks: [{
            "check": "input",
            "test": ":Person",
            "failMsg": "You'll want to limit your nodes to ones labeled Person"
          }, {
            "check": "input",
            "test": ":ACTED_IN",
            "failMsg": "Your paths should use the ACTED_IN relationship"
          }, {
            "check": "input",
            "test": "(\\.name|name:)",
            "failMsg": "You probably want to check the name property"
          }, {
            "check": "input",
            "test": "Tom Hanks",
            "failMsg": "You wanted to look for Tom Hanks's colleagues"
          }, {
            "check": "input",
            "test": "\\.born [<>]",
            "failMsg": "Compare the born (year) property"
          }, {
            "check": "output",
            "results": "Jim Broadbent",
            "failMsg": "We expected someone else."
          }]
        }
      });

      renderGadget('#allMoviesTomHanksActedIn', {
        label: "Try it out: Lab: All Movies Tom Hanks acted in.",
        cypherSetup: "full",
        task: {
          message: "Lab: All Movies Tom Hanks acted in.",
          description:"Find all movies Tom Hanks acted in.",
          solution:`MATCH (tom:Person)-[:ACTED_IN]->(movie)
WHERE tom.name="Tom Hanks"
RETURN movie.title AS Movies`,
          tasks: [{
            "check": "input",
            "test": ":Person",
            "failMsg": "You'll want to limit your nodes to ones labeled Person"
          }, {
            "check": "input",
            "test": ":ACTED_IN",
            "failMsg": "Your paths should use the <code>ACTED_IN</code> relationship"
          }, {
            "check": "input",
            "test": "(\\.name|name:)",
            "failMsg": "You probably want to check the name property"
          }, {
            "check": "input",
            "test": "Tom Hanks",
            "failMsg": "You wanted to look for Tom Hank's movies"
          }, {
            "check": "output",
            "results": "Cloud Atlas",
            "failMsg": "We expected some other movie."
          }]
        }
      });

      renderGadget('#allMoviesKeanuReevesActedIn', {
        label: "Try it out: Lab: All Movies Keanu Reeves acted in.",
        cypherSetup: "full",
        task: {
          solution:`MATCH (keanu:Person)-[:ACTED_IN]->(movie)
WHERE keanu.name = "Keanu Reeves"
RETURN movie.title AS Movies`,
          message: "Lab: All Movies Keanu Reeves acted in.",
          description: "Find all <code>Movies</code> Keanu Reeves acted in.",
          tasks: [{
            "check": "input",
            "test": ":Person",
            "failMsg": "You'll want to limit your nodes to ones labeled Person"
          }, {
            "check": "input",
            "test": ":ACTED_IN",
            "failMsg": "Your paths should use the ACTED_IN relationship"
          }, {
            "check": "input",
            "test": "(\\.name|name:)",
            "failMsg": "You probably want to check the name property"
          }, {
            "check": "input",
            "test": "Keanu Reeves",
            "failMsg": "You wanted to look for Keanu Reeves's movies"
          }, {
            "check": "output",
            "results": "The Matrix",
            "failMsg": "We expected some other movie."
          }]
        }
      });

      renderGadget('#matchingPathsPractice', {
        label: "Try it out: Adding patterns to paths",
        cypherSetup: "full",
        task: {
          message: "Adding patterns to paths",
          tasks: [{
            "check": "input",
            "test": ":ACTED_IN|:DIRECTED",
            "failMsg": "Your paths should contain both, the ACTED_IN and DIRECTED relationships."
          }, {
            "check": "input",
            "test": "p.?\\s*=",
            "failMsg": "You should assign the path expression to a path 'p' or 'p1'"
          }]
        }
      });

      renderGadget('#directorsThatActedInTheirMovies', {
        label: "Try it out: Lab: Find out which directors also acted in their movies",
        cypherSetup: "full",
        task: {
          solution:`MATCH (actor:Person)-[:ACTED_IN]->(movie:Movie)<-[:DIRECTED]->(actor)
RETURN actor.name AS Actors`,
          description:"<code>RETURN</code> people who both <code>ACTED_IN</code> and <code>DIRECTED</code> the same <code>Movie</code> and display their name.",
          message: "Lab: Find out which directors also acted in their movies, use what you've learned so far",
          tasks: [{
            "check": "input",
            "test": ":ACTED_IN|:DIRECTED",
            "failMsg": "Your paths should contain both the ACTED_IN and DIRECTED relationships."
          }, {
            "check": "output",
            "test": "Clint Eastwood",
            "failMsg": "We expected someone else."
          }]
        }
      });

      renderGadget('#aggregationPratice', {
        label: "Try it out: Aggregation",
        cypherSetup: "full",
        task: {
          message: "Aggregation",
          tasks: [{
            "check": "input",
            "test": ":Person",
            "failMsg": "You'll want to start at nodes labeled Person"
          }, {
            "check": "input",
            "test": ":ACTED_IN",
            "failMsg": "Your paths should use the ACTED_IN relationship"
          }, {
            "check": "input",
            "test": "(collect|count|avg|min|max)",
            "failMsg": "You certainly wanted to use an aggregation function"
          }]
        }
      });

      renderGadget('#fiveBusiestActors', {
        label: "Try it out: Lab: Find the five busiest actors",
        cypherSetup: "full",
        task: {
          solution:`MATCH (actor:Person)-[:ACTED_IN]->(movie)
RETURN actor.name AS Actor, count(movie) AS Movies
ORDER BY count(movie) DESC
LIMIT 5`,
          message: "Lab: Find the 5 busiest actors",
          tasks: [{
            "check": "input",
            "test": ":ACTED_IN",
            "failMsg": "Your paths should use the ACTED_IN relationship"
          }, {
            "check": "input",
            "test": "count",
            "failMsg": "You probably want to count the ocurrences"
          }, {
            "check": "input",
            "test": "order by",
            "failMsg": "Ordering the results makes a lot of sense for top n"
          }, {
            "check": "input",
            "test": "desc",
            "failMsg": "Remember to use the right sort order."
          }, {
            "check": "input",
            "test": "limit 5",
            "failMsg": "You're still interested in the top 5, remember how to limit the output?"
          }, {
            "check": "output",
            "test": "Gene Hackman",
            "failMsg": "We expected someone else."
          }]
        }
      });

      renderGadget('#recommendActorsForKeanu', {
        label: "Try it out: Lab: Recommend 3 actors that Keanu Reeves should work with",
        cypherSetup: "full",
        task: {
          message: "Lab: Recommend 3 actors that Keanu Reeves should work with (but hasn't)",
          tasks: [{
            "check": "input",
            "test": "Keanu Reeves",
            "failMsg": "You should look for Keanu Reeves"
          }, {
            "check": "input",
            "test": ":ACTED_IN",
            "failMsg": "Your paths should use the ACTED_IN relationship several times"
          }, {
            "check": "input",
            "test": "count",
            "failMsg": "You probably want to count the ocurrences"
          }, {
            "check": "input",
            "test": "order by",
            "failMsg": "Ordering the results makes a lot of sense for top n"
          }, {
            "check": "input",
            "test": "desc",
            "failMsg": "Remember to use the right sort order."
          }, {
            "check": "input",
            "test": "limit 3",
            "failMsg": "You're still interested in the top 3, remember how to limit the output?"
          }, {
            "check": "input",
            "test": "not",
            "failMsg": "Did you remember to exclude the ones he already worked with?"
          }]
        }
      });
});

