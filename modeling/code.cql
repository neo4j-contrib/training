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


MATCH (p:Person)
SET p.name = "Emil"

MATCH (p:Person)
RETURN p

MATCH (n)
WITH COUNT(*) AS nodeCount
MATCH ()-[]->()
RETURN nodeCount, COUNT(*) AS relationshipCount

// default setting for enabling all supported metrics
metrics.enabled=true

metrics.graphite.enabled=true // default is 'false'
metrics.graphite.server=<ip>:2003
metrics.graphite.interval=<how often to send data, defaults to 3s>
metrics.prefix=<Neo4j instance name, e.g. wwwneo1>

MATCH ()-[]->()
WITH COUNT(*) AS count
RETURN "relationships" AS type, count

UNION

MATCH ()
WITH COUNT(*) AS count
RETURN "nodes" AS type, count

CALL dbms.listQueries;

MATCH (m), (n), (o)
RETURN COUNT(*)

CALL dbms.listQueries()


YIELD queryId, query
WITH queryId, query WHERE query starts with "MATCH"
RETURN queryId


CALL dbms.killQuery("query-482")

MATCH (alice:Person {name: "Alice"})-[:KNOWS]-(bob:Person {name:"Bob"})
RETURN alice, bob

 MATCH (p1:Person {name: "River Phoenix"})
 MATCH (p2:Person {name: "Hugo Weaving"})
 MATCH path = shortestpath((p1)-[*]-(p2))
 RETURN path

MATCH (p1:Person {name: "Halle Berry"})
MATCH (p2:Person {name: "River Phoenix"})
MATCH path = shortestpath((p1)-[:ACTED_IN*]-(p2))
RETURN path

MATCH (origin:Airport {code: "LAX"})-[flight:HAS_FLIGHT]->(destination:Airport {code: "LAS"})
RETURN origin, destination, flight
LIMIT 10;


CREATE (lax:Airport {code: "LAX"})
CREATE (las:Airport {code: "LAS"})
CREATE (lax)-[flight:CONNECTED_TO]->(las)
SET flight.flightNumber = 82

MERGE (las:Airport {code: "LAS"})
MERGE (lax:Airport {code: "LAX"})
MERGE (las)-[flight:CONNECTED_TO]->(lax)

MATCH (las:Airport {code: "LAS"})
MATCH (lax:Airport {code: "LAX"})
MERGE (las)-[flight:CONNECTED_TO]->(lax);

MERGE (las:Airport {code: "LAS"})
RETURN las;

MATCH (person:Person)-[:IS_FRIEND_OF]->(friend),
   (friend)-[:LIKES]->(restaurant),
      (restaurant)-[:LOCATED_IN]->(loc:Location),
      (restaurant)-[:SERVES]->(type:Cuisine)

WHERE person.name = 'Philip' AND loc.location='New York' AND
      type.cuisine='Sushi'

RETURN restaurant.name;

CREATE (p:Person {name: 'Your Name'})
RETURN p;

MATCH (p:Person {name: 'Your Name'})
RETURN p;

->
MATCH (n) DETACH DELETE n;

CREATE CONSTRAINT ON (p:Person) ASSERT p.name IS UNIQUE;

MATCH (p:Person {name: 'Your Name'})
SET p.city = 'Your City'
RETURN p;

MATCH (p:Person)
RETURN p.name, p.city;

MATCH (p:Person)
RETURN p.city, collect(p.name) AS people, count(*) AS number
ORDER BY number DESC
LIMIT 3;

MATCH (p:Person)
RETURN p.city, collect(p.name) AS people;

MATCH (p:Person)
RETURN p.city, collect(p.name) AS people, count(*) AS number
ORDER BY number DESC
LIMIT 3;

CREATE (p:Person {name: 'Your Name'});

MERGE (p:Person {name: 'Your Name'})
RETURN p;

MATCH (p1:Person {name: 'Your Name'})
MATCH (p2:Person {name: 'Your Neighbour'})
RETURN p1, p2;

MATCH (p1:Person {name: 'Your Name'}),
      (p2:Person {name: 'Your Neighbour'})
RETURN p1, p2;

MATCH (p1:Person {name: 'Your Name'})
MATCH (p2:Person {name: 'Your Neighbour'})
CREATE (p1)-[:KNOWS]->(p2);

MATCH (p1:Person {name: 'Your Name'})
MATCH (p2:Person {name: 'Your Neighbour'})
MERGE (p1)-[:KNOWS]->(p2);

MATCH (p:Person {name: 'Your Name'})
DELETE p;

MATCH (p:Person {name: 'Your Name'})
DETACH DELETE p;

PROFILE
MATCH
(m:Movie)<-[:ACTED_IN]-(a:Person)
RETURN m.title, count(*) as cast
ORDER BY cast DESC
LIMIT 10;

PROFILE
MATCH (m:Movie)
RETURN m.title,
 size( (m)<-[:ACTED_IN]-() ) as cast
ORDER BY cast DESC
LIMIT 10;

MATCH (m:Movie)
UNWIND m.genres as genre
WITH genre, collect(m) as movies
// 1 lookup per genre
MERGE (g:Genre {name: genre})
WITH g, movies
UNWIND movies as m
CREATE (m)-[:GENRE]->(g);


MATCH (m:Movie)
UNWIND m.genres as genre
// 1 genre lookup per movie
MERGE (g:Genre {name: genre})
CREATE (m)-[:GENRE]->(g);

// mark nodes to process
MATCH (m:Movie) SET :Process;

  // process marked nodes and remove mark
MATCH (m:Movie:Process) WITH m LIMIT 10000
REMOVE m:Process
UNWIND m.genres as genre
MATCH (g:Genre {name: genre})
CREATE (m)-[:GENRE]->(g)
RETURN count(*);

MATCH (m) WHERE not exists (m)-[:GENRE]->()
WITH m LIMIT 10000
UNWIND m.genres as genre
MATCH (g:Genre {name: genre})
CREATE (m)-[:GENRE]->(g)
RETURN count(*);

PROFILE
MATCH  (p:Person)-[:ACTED_IN]->(m:Movie)<-[:ACTED_IN]-
       (p2:Person)-[:ACTED_IN]->(m2:Movie)
WHERE p.name = "Tom Hanks"
RETURN count(*), count(distinct m2);

PROFILE
MATCH  (p:Person)-[:ACTED_IN]->(m:Movie)<-[:ACTED_IN]-
       (p2:Person)
WHERE p.name = "Tom Hanks"
WITH distinct p2
MATCH (p2)-[:ACTED_IN]->(m2:Movie)
RETURN count(*), count(distinct m2);


MATCH (las:Airport {code: "LAS"})
MATCH (lax:Airport {code: "LAX"})
CREATE (las)-[connection:CONNECTED_TO { airline: "WN",
  flightNumber: "82",
  date: "2008-1-3",
  departure: 1715,
  arrival: 1820}]->(lax);


MATCH (origin:Airport {code: "LAS"})-[:HAS_DAY]->(originDay:AirportDay)<-[:ORIGIN]-(flight:Flight),
      (flight)-[:DESTINATION]->(destinationDay:AirportDay)<-[:HAS_DAY]-(destination:Airport {code: "MDW"})
WHERE originDay.date IN ["2008-1-3", "2008-1-4"] AND destinationDay.date IN ["2008-1-3", "2008-1-4"] AND originDay.date = destinationDay.date
RETURN flight.date, flight.number, flight.airline, flight.departure, flight.arrival
ORDER BY flight.date, flight.departure;

MATCH (origin:Airport {code: "LAS"})-[:HAS_DAY]->(originDay:AirportDay),
      (originDay)<-[:ORIGIN]-(flight:Flight),
      (flight)-[:DESTINATION]->(destinationDay),
      (destinationDay:AirportDay)<-[:HAS_DAY]-(destination:Airport {code: "MDW"})

WHERE originDay.date = "2008-1-3"
AND destinationDay.date = "2008-1-3"

RETURN flight.date, flight.number, flight.airline, flight.departure, flight.arrival
ORDER BY flight.date, flight.departure;

MATCH (origin:Airport {code: "LAS"})-[:`2008-1-3`]->(originDay:AirportDay),
      (originDay)<-[:ORIGIN]-(flight:Flight),
      (flight)-[:DESTINATION]->(destinationDay),
      (destinationDay:AirportDay)<-[:`2008-1-3`]-(destination:Airport {code: "MDW"})

RETURN flight.date, flight.number, flight.airline, flight.departure, flight.arrival
ORDER BY flight.date, flight.departure;


MATCH (origin:Airport {code: "LAS"})-[:HAS_DAY]->(originDay:AirportDay),
      (originDay)<-[:ORIGIN]-(flight:Flight),
      (flight)-[:DESTINATION]->(destinationDay),
      (destinationDay:AirportDay)<-[:HAS_DAY]-(destination:Airport {code: "MDW"})

WHERE originDay.date IN ["2008-1-3", "2008-1-4", "2008-1-5"]
AND destinationDay.date IN ["2008-1-3", "2008-1-4", "2008-1-5"]
AND originDay.date = destinationDay.date

RETURN flight.date, flight.number, flight.airline, flight.departure, flight.arrival
ORDER BY flight.date, flight.departure;

MATCH (origin:Airport {code: "LAS"})-[originDate:`2008-1-3`|:`2008-1-4`|:`2008-1-5`]->(originDay:AirportDay),
      (originDay)<-[:ORIGIN]-(flight:Flight),
      (flight)-[:DESTINATION]->(destinationDay),
      (destinationDay:AirportDay)<-[destinationDate:`2008-1-3`|:`2008-1-4`|:`2008-1-5`]-(destination:Airport {code: "MDW"})

WHERE TYPE(originDate) = TYPE(destinationDate)

RETURN flight.date, flight.number, flight.airline, flight.departure, flight.arrival
ORDER BY flight.date, flight.departure;

MATCH (origin:Airport {code: "LAS"})-[:HAS_DAY]->(originDay:AirportDay),
      (originDay)<-[:ORIGIN]-(flight:Flight),
      (flight)-[:DESTINATION]->(destinationDay),
      (destinationDay:AirportDay)<-[:HAS_DAY]-(destination:Airport {code: "MDW"})

WHERE originDay.y IN ["2008-1-3", "2008-1-4", "2008-1-5"]
AND destinationDay.date IN ["2008-1-3", "2008-1-4", "2008-1-5"]
AND originDay.date = destinationDay.date

RETURN flight.date, flight.number, flight.airline, flight.departure, flight.arrival
ORDER BY flight.date, flight.departure;
















