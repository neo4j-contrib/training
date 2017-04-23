# Creating Nodes with Cypher

Let's start by adding a node to the graph.

![Create a Node](https://vimeo.com/77868063)

Let's follow along with the video. Run the following query, replacing *My Name* with your name in quotes (if you happen to have the same name as a famous actor you might want to change what name you put in):

    CREATE (me:Person {name: "My Name"}) return me;

You will see the new node returned and also as part of the visualization. You can also easily check for its existence with the following query.

    MATCH (me:Person)
    WHERE me.name="My Name"
    RETURN me.name;

or

    MATCH (me:Person {name:"My Name"})
    RETURN me.name;

// include::lesson1.adoc
// console id=lesson1


