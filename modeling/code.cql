WITH point({latitude: 37.7952919, longitude: -122.4036433}) AS location1,
     point({latitude: 51.486323, longitude: -0.106042}) AS location2
RETURN distance(location1, location2)

MATCH (m1:Process) WITH m1 LIMIT 1000
REMOVE m1:Process
WITH m1
// do the refactoring


MATCH (member:Member {name: "Mark Needham"})
OPTIONAL MATCH (member)-[:MEMBER_OF]->(group)
RETURN member, COLLECT(group) AS groups

LOAD CSV     // load csv data
WITH HEADERS // optionally use first header row as keys in "row" map
FROM "url"   // file:// URL relative to $NEO4J_HOME/import or http://
AS row       // return each row of the CSV as list of strings or map

// ... rest of the Cypher statement ...


LOAD CSV WITH HEADERS FROM "file:///flights.csv" AS row
CREATE (:Airport {code: row.Origin})

LOAD CSV WITH HEADERS FROM "file:///flights.csv" AS row
CREATE (:Airport {code: row.Origin})
CREATE (:Airport {code: row.Dest})

LOAD CSV WITH HEADERS FROM "file:///flights.csv" AS row
CREATE (origin:Airport {code: row.Origin})
CREATE (destination:Airport {code: row.Dest})
CREATE (origin)-[:FLIGHT {flightNumber: row.flightNum, airline: row.UniqueCarrier}]->(destination)


LOAD CSV WITH HEADERS FROM "file:///flights.csv" AS row
MATCH (origin:Airport {code: row.Origin})
MATCH (destination:Airport {code: row.Dest})

LOAD CSV WITH HEADERS FROM "file:///flights.csv" AS row
MERGE (origin:Airport {code: row.Origin})
MERGE (destination:Airport {code: row.Dest})
MERGE (origin)-[:FLIGHT {flightNumber: row.flightNum, airline: row.UniqueCarrier}]->(destination)

LOAD CSV WITH HEADERS FROM "file:///flights.csv" AS row
MATCH (origin:Airport {code: row.Origin})
MATCH (destination:Airport {code: row.Dest})


MATCH (origin)-[flight:FLIGHT {flightNumber: row.flightNum}]->(destination)
SET flight.airline = row.UniqueCarrier

CREATE CONSTRAINT ON (label:Label)
ASSERT label.property IS UNIQUE

CREATE INDEX ON :Label(property)

EXPLAIN
MATCH (origin:Airport)-[flight:FLIGHT]
      ->(destination:Airport)
WHERE destination.code = "LAS"
RETURN origin, destination, flight
LIMIT 10

MATCH (movie:Movie {title:"The Matrix"})
RETURN movie

// defaults to 1000
USING PERIODIC COMMIT 10000
LOAD CSV
...

RETURN split("1;2;3", ";") AS topicIds
[1, 2, 3]


UNWIND [1,2,3] AS value
RETURN value
1
2
3

MATCH (actor:Person)-[rel:ACTED_IN]->(movie:Movie)
RETURN rel.roles, actor.name

MATCH (m1:Process) WITH m1 LIMIT 1000
REMOVE m1:Process
WITH m1
// do the refactoring


UNWIND split("1;2;3", ";") AS topicId
RETURN topicId
1
2
3


MATCH (member:Member {name: "Mark Needham"})
OPTIONAL MATCH (member)-[:MEMBER_OF]->(group)
RETURN member, COLLECT(group) AS groups

MATCH (person:Person {name: "Tom Hanks"})
      -[role:DIRECTED|:ACTED_IN]->(movie)
RETURN movie, COLLECT(TYPE(role)) AS roles
ORDER BY LENGTH(roles) DESC



