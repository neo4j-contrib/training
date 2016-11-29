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







MATCH (:Person {name:'Eric'})-[:KNOWS]-(p2)
RETURN p2;

CALL dbms.security.listRoles();
CALL dbms.security.createUser("restrictedUser", "neo4j", false);

CALL dbms.security.addRoleToUser("reader", "restrictedUser");

CREATE (p:Person);


MATCH (origin:Airport {code: "LAS"})-[:HAS_DAY]->(originDay:AirportDay),
      (originDay)<-[:ORIGIN]-(flight:Flight)

WHERE date STARTS WITH "2008-1"

RETURN flight.date, flight.number, flight.airline, flight.departure, flight.arrival

ORDER BY flight.date, flight.departure;

MATCH (origin:Airport {code: "LAS"})-[:`2008-1-3`|:`2008-1-4`|`2008-1-5`]->(originDay:AirportDay),
      (originDay)<-[:ORIGIN]-(flight:Flight)

RETURN flight.date, flight.number, flight.airline, flight.departure, flight.arrival

ORDER BY flight.date, flight.departure;

CALL dbms.cluster.overview();


UNWIND range(0, 100) AS value
MERGE (p1:Person {id: value})
MERGE (p2:Person {id: TOINT(100.0 * rand())})
MERGE (p1)-[:FRIENDS]->(p2);

MATCH path = (p:Person)-[:FRIENDS]-(friend)
RETURN path
LIMIT 10
;

CALL dbms.security.createRole("movies_only")
CALL dbms.security.createUser("lockedDown", "abc", false)
CALL dbms.security.addRoleToUser("movies_only", "lockedDown")

CALL dbms.security.listRoles()

CALL training.actors("Tom Hanks")

MATCH (n)
RETURN n
LIMIT 5;

MATCH (airport {code:  "LAX"})
MERGE (airportDay:AirportDay {id: "LAX_2008-2-1"})
ON CREATE SET airportDay.date = "2008-2-1"
CREATE (airport)-[:HAS_DAY]->(airportDay)
CREATE (airport)-[:`2008-2-1`]->(airportDay);


MATCH (airport {code:  "LAX"})
MATCH (airportDay:AirportDay {id: "LAX_2008-2-1"})
MATCH (airport)-[general:HAS_DAY]->(airportDay)
MATCH (airport)-[specific:`2008-2-1`]->(airportDay)
DELETE general, specific;

MATCH (m:Movie)
RETURN m;

MATCH (p:Person)-[r:ACTED_IN]->(m:Movie)
RETURN p, r, m;

MATCH p = (:Person)-[:ACTED_IN]->(:Movie)
RETURN p;

MATCH (m:Movie)
RETURN m.title AS title;

MATCH (p:Person)-[:ACTED_IN]->(m:Movie)
RETURN p.name, count(*) AS movies;

CREATE CONSTRAINT ON (label:Label)
ASSERT EXISTS(label.name);

CREATE CONSTRAINT ON ()-[rel:REL_TYPE]->()
ASSERT EXISTS(rel.name);

MATCH ...
RETURN collect(DISTINCT n);

CREATE(n:Person)
CREATE(n:GraphDatabase)
CREATE(n:VeryDescriptiveLabel)

CREATE(n)-[:LOVES]->(m);
CREATE(n)-[:REALLY_LOVES]->(m);
CREATE(n)-[:IS_IN_LOVE_WITH]->(m);

CREATE(n)
SET n.name = 'Dave';

CREATE(n)
SET n.firstName = 'Dave';

CREATE(n)
SET n.firstAndLastName = 'Dave Gordon';

MATCH (m:Movie {title: 'The Matrix'})
SET m.genre = ['Action', 'Sci-Fi']
RETURN m;

MATCH (m:Movie {title: 'The Matrix'})
SET m.genre = ['Action', 'Sci-Fi']
RETURN m;

MATCH (m:Movie {title:"The Matrix"})
RETURN m.genre;

MATCH (m:Movie {title:"The Matrix"})
RETURN m.genre;

MATCH (m1:Movie), (m2:Movie)
WHERE any(x IN m1.genre WHERE x IN m2.genre)
      AND m1 <> m2
RETURN m1, m2;

MATCH (m:Movie {title:"The Matrix"})
MERGE (action:Genre {name:"Action"})
MERGE (scifi:Genre {name:"Sci-Fi"})
MERGE (m)-[:IN_GENRE]->(action)
MERGE (m)-[:IN_GENRE]->(scifi);

MATCH (m:Movie {title:"Mystic River"})
MERGE (action:Genre {name:"Action"})
MERGE (mystery:Genre {name:"Mystery"})
MERGE (m)-[:IN_GENRE]->(action)
MERGE (m)-[:IN_GENRE]->(mystery);

MATCH (m1:Movie)-[:IN_GENRE]->(g:Genre),
      (m2:Movie)-[:IN_GENRE]->(g)
RETURN m1, m2, g;

MATCH (m:Movie {title:"The Matrix"}),
      (m)-[:IN_GENRE]->(g:Genre)
RETURN g.name;

CALL apoc.create.uuid() YIELD uuid
CALL apoc.data.formatDefault(timestamp(), "ms") YIELD value AS date
CREATE (:Document {id: uuid, created:date});

CREATE (:Document {id: apoc.create.uuid(), date: apoc.data.formatDefault(timestamp(), "ms")});

PROFILE
WITH ['Action','Drama','Mystery'] AS genreNames
UNWIND genreNames AS name
MATCH (g:Genre {name:name})<-[:GENRE]-(m:Movie)
WITH m, collect(g) AS genres, genreNames
WHERE size(genres) = size(genreNames)
RETURN m;

PROFILE
WITH ['Action','Drama','Mystery'] AS genreNames
UNWIND genreNames AS name
MATCH (g:Genre {name:name})
WITH g ORDER BY size( (g)<-[:GENRE]-() ) ASC
WITH collect(g) AS genres
WITH head(genres) AS first, tail(genres) AS rest
MATCH (first)<-[:GENRE]-(m:Movie)
WHERE all(g IN rest WHERE (m)-[:GENRE]->(g))
RETURN m;

PROFILE
WITH ['Action','Drama','Mystery'] AS genreNames
UNWIND genreNames AS name
MATCH (g:Genre {name:name})
WITH g ORDER BY size( (g)<-[:GENRE]-() ) ASC
WITH collect(g) AS genres
WITH head(genres) AS first, tail(genres) AS rest
MATCH (first)<-[:GENRE]-(m:Movie)-[:GENRE]->(other)
WITH m, collect(other) AS movieGenres, rest
WHERE all(g IN rest WHERE g IN movieGenres)
RETURN m;

CREATE (p:Person)// create labeled node
SET p:Person     // set label on node
REMOVE p:Person  // remove label

MATCH (p:Person) // match nodes with label
WHERE p:Person   // label predicate
RETURN labels(p) // get label collection

… // a simple pattern, with RELTYPE
MATCH (n)-[:LINK]-(m)


… // match a complex pattern
MATCH (n)-->(m)<--(o), (p)-->(m)

… // match a variable-length path
MATCH p=(n)-[:LINKED*]-()

… // use a specialized matcher
MATCH p=shortestPath((n)-[*]-(o));

… // filter on a property value
WHERE n.name = "Andrés"

… // filter with predicate patterns
WHERE NOT (n)<--(m)

… // filter on path/collection length
WHERE length(p) > 3

… // filter on multiple predicates
WHERE n.born < 1980 AND n.name =~ "A.*";

… // p aliased to person
RETURN p AS person


… // implicit group by n, count(*)
RETURN n, count(*) AS count

… // collect things into a collection
RETURN n, collect(r);

… // descending sort, limit 5
RETURN n, count(*) AS count
ORDER BY count DESC
LIMIT 5

… // get the next 5
RETURN n, count(*) as count
ORDER BY count DESC
SKIP 5
LIMIT 5;

... // intermediate projection, ordering, pagination
WITH a.name as name, a.born as born
ORDER BY born DESC
LIMIT 5
...

... // aggregation + filter
WITH m, count(*) as cast, collect(a.name) as actors
WHERE cast > 5
RETURN m.title, actors;

CREATE (m:Movie {title:"The Matrix", released:1999})
UNWIND ["Lilly Wachowski","Lana Wachowski"] AS name
MATCH  (d:Director {name:name})
CREATE (d)-[:DIRECTED]->(m);

UNWIND {data} AS pair
MERGE (m:Movie {id:pair.movieId})
  ON CREATE SET m += pair.movieData
  ON MATCH  SET m.updated = timestamp()
MERGE (p:Person {id:pair.personId})
  ON CREATE SET p += pair.personData
MERGE (p)-[r:ACTED_IN]->(m)
  ON CREATE SET r.roles = split(pair.roles,";");

  MATCH (a:Person)
  WHERE (a)-[:ACTED_IN]->()
  SET a:Actor


  MATCH (m:Movie) WHERE exists(m.movieId)
  SET m.id = m.movieId
  REMOVE m.movieId;

  // will delete Tom Hanks and all his
  // relationships
  MATCH (p:Person {name: "Tom Hanks"})
  DETACH DELETE p

  // will delete everything in db
  MATCH (n)
  DETACH DELETE n;



// note that aliases are the same
MATCH (a:Actor)
RETURN a.name as name
UNION
MATCH (d:Director)
RETURN d.name as name;


… // group by age-range
RETURN CASE
  WHEN p.age < 20 THEN 'under 20'
  WHEN p.age < 30 THEN 'twenties'
  …
  END AS age_group;

  MATCH (a:Person)-[:ACTED_IN]->(m:Movie)
  WHERE a.name STARTS WITH "T"
  WITH a, count(m) AS cnt,
       collect(m.title) AS movies
  WHERE cnt > 5
  RETURN {name: a.name, movies: movies} as data
  ORDER BY length(data["movies"]) DESC
  LIMIT 10;

  // sum of items in [1,2,3,4]
  RETURN reduce(acc=0, x in [1,2,3,4] | acc + x)
  // first element in [1,2,3,4]
  RETURN [1,2,3,4][0]
  // last element in [1,2,3,4]
  RETURN [1,2,3,4][-1]
  // get the elements that are above 2
  RETURN [x in [1,2,3,4] WHERE x > 2];


  // we'll create some nodes
  // from properties in a collection
  WITH ["Drama","Action",...] AS genres
  FOREACH(name in genres|
    CREATE (:Genre {name:name})
  );



MATCH (m:Movie)<-[:ACTED_IN]-(p)
WITH collect(p) AS actors,
     count(p) AS actorCount, m
UNWIND actors AS actor
RETURN m, actorCount, actor;

MATCH (a:Actor)
RETURN a.name AS name
UNION
MATCH (d:Director)
RETURN d.name AS name
// no means for sort / limit


MATCH (a:Actor)
WITH collect(a.name) AS actors
MATCH (d:Director)
WITH actors, collect(d.name) AS directors
UNWIND (actors + directors) AS name
RETURN DISTINCT name
ORDER BY name ASC LIMIT 10;

// create and drop an index
CREATE INDEX ON :Director(name);
DROP INDEX ON :Director(name);

// use an index for a lookup
MATCH (p:Person)
WHERE p.name="Clint Eastwood"
RETURN p;

MATCH (p:Person)
WHERE p.born > 1980 RETURN p;


MATCH (m:Movie)
WHERE 2000 <= m.released < 2010 RETURN m;


MATCH (p:Person)
WHERE p.name >= "John"
RETURN p;


MATCH (p:Person)
WHERE p.name STARTS WITH "John" RETURN p;


MATCH (p:Person)
WHERE p.name CONTAINS "Wachowski" RETURN p;


MATCH (m:Movie)
WHERE m.title CONTAINS "Matrix" RETURN m;

MATCH (a:Actor)-->(m:Movie:Comedy)
RETURN count(distinct a);

vs

MATCH (a:Actor)-->(m:Movie:Comedy)
USING SCAN m:Comedy
RETURN count(distinct a);

CREATE CONSTRAINT ON (p:Person)
ASSERT p.id IS UNIQUE;


CREATE CONSTRAINT ON (p:Person)
ASSERT p.id IS UNIQUE
CREATE CONSTRAINT ON (p:Person)
ASSERT exists(p.name)
CREATE CONSTRAINT ON (:Person)-[r:ACTED_IN]->(:Movie)
ASSERT exists(r.roles)


MATCH (m:Movie)
RETURN m { .title, .genres } AS movie


MATCH (m:Movie)<-[:ACTED_IN]-(p:Person)
WITH collect(p) AS people
RETURN m { .title, .genres,  cast: [p in people | p.name] } AS movie;


MATCH (m:Movie)
RETURN m.title, [ (m)<-[:ACTED_IN]-(p:Person) | p.name ] AS cast


MATCH (m:Movie)
RETURN m { .title, .genres,
   cast: [ (m)<-[r:ACTED_IN]-(p:Person) | {name: p.name, roles: r.roles} ] }
AS movie;

WITH range(1,9) AS list
WHERE all(x IN list WHERE x < 10)
   AND any(x in [1,3,5] WHERE x IN list)
WITH [x IN list WHERE x % 2 = 0 | x*x ] as squares
UNWIND squares AS s
RETURN s;

MATCH (movie:Movie)
UNWIND keys(movie) as key
WITH movie, key
WHERE key ENDS WITH "_score"
RETURN avg(movie[key])

MATCH (g:Genre)
WITH collect([g.name, g]) AS pairs
CALL apoc.map.fromPairs(pairs) YIELD value AS genres
MATCH (m) WHERE not exists (m)-[:GENRE]->()
WITH genres, m LIMIT 10000
UNWIND m.genres as genre
WITH genres[genre] as g, m
CREATE (m)-[:GENRE]->(g)
RETURN count(*);

CREATE INDEX ON :Movie(title);
CREATE INDEX ON :Movie(releaseYear);

MATCH (m:Movie) WHERE m.title CONTAINS "The"
MATCH (n:Movie) WHERE 1990 < n.releaseYear < 2000 AND n = m
RETURN m;

MATCH (a:User {name:"A"})
       -[:KNOWS]->(b)-[:KNOWS]->(c)
WHERE a <> c
AND NOT (a)-[:KNOWS]->(c)
RETURN c;

MATCH (m:Movie), (p:Person)
RETURN count(distinct m), count(distinct p);

MATCH (m:Movie) WITH count(*) AS movies
MATCH (p:Person) RETURN movies, count(*) AS people;

MATCH (m:Movie) RETURN {movies: count(*)} AS c UNION ALL
MATCH (p:Person) RETURN {people: count(*)} AS c;

FOREACH(ignoreMe IN CASE WHEN EXISTS(person.country) THEN [1] ELSE [] END |
 MERGE (country:Country {name: person.country})
 MERGE (person)-[:LIVES_IN]->(country)
);


CREATE(:Director {_id: ["id1", "id2", "id3"] });
CREATE INDEX ON :Director(_id);















































