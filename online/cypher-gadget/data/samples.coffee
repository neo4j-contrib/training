define [], () ->
  {
    read: [
      {
        desc: "Get all of the nodes in a graph"
        query: "MATCH (x)
              \nRETURN x;"
      }, {
        desc: "Get all nodes and relationships between nodes, naming the columns"
        query: "MATCH (n)-[r]->(m)
              \nRETURN n as node_a, r as relates_to, m as node_b;"
      }, {
        desc: "Find a specific node (within all-nodes)"
        query: "MATCH (person:Person)
              \nWHERE person.name = \"Hugo Weaving\"
              \nRETURN person;"
      }, {
        desc: "Naming a relationship and returning its type"
        query: "MATCH (actor)-[r]-> ()
              \nRETURN actor.name, type(r);"
      }, {
        desc: "Matching a relationship type"
        query: "MATCH (actor) -[:ACTED_IN]-> (movie)
              \nRETURN actor, movie;"
      }
    ], write: [
      {
        desc: "Create a node with the name \"Mystic River\" and label \"Movie\""
        query: "CREATE (:Movie {title:\"Mystic River\", released:1993})"
      }, {
        desc: "Add a property (tagline) to a node (Mystic River)."
        query: "MATCH (movie:Movie)
              \nWHERE movie.title=\"Mystic River\"
              \nSET movie.tagline = \"We bury our sins here, Dave. We wash them clean\"
              \nRETURN movie;"
      }, {
        desc: "Create a relationship between two nodes (Kevin Bacon in Mystic River)"
        query: "MATCH (movie:Movie),(actor:Person)
              \nWHERE movie.title=\"Mystic River\" AND actor.name=\"Kevin Bacon\"
              \nMERGE (actor)-[role:ACTED_IN]->(movie) ON CREATE SET role.roles = [\"Sean\"]"
      }, {
        desc: "Delete all nodes with the title \"Mystic River\""
        query: "MATCH (movie:Movie)
              \nWHERE movie.title=\"Mystic River\"
              \nDETACH DELETE movie;"
      }
    ]
  }

