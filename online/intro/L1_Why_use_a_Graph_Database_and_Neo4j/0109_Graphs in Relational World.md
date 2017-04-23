# Notes: Graphs in Relational World

### Relational Databases
Most of you know relational databases. They store data in tables, each of which consists of rows and columns, much like a spreadsheet. Each column has a name and a type. Each row represents an entry or entity. Consistency is guaranteed through additional constraints that can be placed on the database's *schema* and through transactional ACID compliance.

Relationships between tables are computed at query time by matching primary and foreign keys. These connections are hinted and enforced by *Foreign Key Constraints* which only can be applied to non-optional relationships. If you want to represent a higher cardinality (m:n) you need an additional intermediate **JOIN-Table** that connects both entity tables.

Especially SQL queries with multiple JOIN operations are getting very costly due to the need to compute the relationships at query time.

----

![](../images/slides_rdbms_01.png)
We have a customer, Alice with three accounts. 

![](../images/slides_rdbms_02.png)
To keep track of which accounts Alice owns, we need a third table to store the mapping of account types. This is called a JOIN table.

![](../images/slides_rdbms_03.png)
Let’s look only at the data.

![](../images/slides_rdbms_04.png)
The mappings are just relationships in a graph. 

![](../images/slides_rdbms_05.png)
Alice and the individual accounts are all Nodes with Labels.


----

### Relationships in a graph naturally form paths.
Querying—or traversing—the graph involves following paths. Because of the fundamentally path-oriented nature of the data model, the majority of path-based graph database operations are highly aligned with the way in which the data is laid out, making them extremely efficient.

----

Ian Robinson, Jim Webber, and Emil Eifrém. *Graph Databases*. O'Reilly Media, 2013, p. 20
** **
End of Section
**(Graph NOTES) -- (Graphs in a Relational World) --> (Review of LESSON ONE)**