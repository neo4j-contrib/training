# Lab: Aggregates: Count

Try to come up with a query that will display the five busiest actors (the five actors who have acted in the most movies).

***Hint***: Use aggregation and ordering

// console id:full



**Solution**

<pre style="color:transparent">    
    MATCH (a:Person)-[:ACTED_IN]->(m)
    RETURN a.name, count(m)
    ORDER BY count(m) DESC
    LIMIT 5;
</pre>