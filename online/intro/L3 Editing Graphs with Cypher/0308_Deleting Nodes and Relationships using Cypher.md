# Deleting Nodes and Relationships with Cypher

**This query statement will delete both the relationship and the node, 
even though there may be no relationships. **

    MATCH (emil:Person)
    WHERE emil.name="Emil Eifrem"
    OPTIONAL MATCH (emil)-[r]-()
    DELETE emil,r;

The first `MATCH` is obvious, it finds the node we're looking for. There "WHERE" statement belongs to the first MATCH.

The second is an `OPTIONAL MATCH`. It is much like an outer join in SQL. It tries to find nodes matching the pattern, if it doesn't find anything it returns a single row with null values. But it will always return at least one row. You can also filter the optional match with a `WHERE`statement.

The alternative, shorter syntax looks like this:

    MATCH (emil:Person {name:"Emil Eifrem"})
    OPTIONAL MATCH (emil)-[r]-()
    DELETE emil,r;

Try one of them in the graph below.

[id="full"]
{
  "message": "Delete Emil and his relationships",
  "tasks": [
    {
      "check": "input",
      "test": ":Person",
      "failMsg": "You'll want to start at nodes labeled Person"
    },
    {
      "check": "input",
      "test": "name.+Emil Eifrem",
      "failMsg": "You probably want to check the name property for 'Emil Eifrem'"
    },
    {
      "check": "input",
      "test": "OPTIONAL\\s+MATCH",
      "failMsg": "Remember not only to delete Emil but also to match his potential relationships and delete them."
    },
    {
      "check": "input",
      "test": "\\[\\w+\\]",
      "failMsg": "You probably wanted to assign an identifier to your relationship"
    },
    {
      "check": "input",
      "test": "DELETE",
      "failMsg": "You most probably want to DELETE Emil and his relationships"
    }
  ]
}

