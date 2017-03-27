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

MATCH p=(:Character)-[:INTERACTS]-(:Character)
RETURN p;

LOAD CSV WITH HEADERS FROM "https://www.macalester.edu/~abeverid/data/stormofswords.csv" AS row
MERGE (src:Character {name: row.Source})
MERGE (tgt:Character {name: row.Target})
MERGE (src)-[r:INTERACTS]->(tgt)
ON CREATE SET r.weight = toInt(row.Weight);

CREATE CONSTRAINT ON (c:Character) ASSERT c.name IS UNIQUE;






// find starting points
MATCH (:Person {name:'Andreas'})
// then traverse the relationships
       -[:ACTED_IN]->(movie:Movie)
      <-[:ACTED_IN]- (other:Person)
// and return results
RETURN other;

MATCH (boss)-[:MANAGES*0..3]->(mgr)

WHERE boss.name = "John Doe" AND
      (mgr)-[:MANAGES]->()
RETURN mgr.name AS Manager,
  size((mgr)-[:MANAGES*1..3]->()) AS Total;


  MATCH (m:Movie {title:row.movie}), (p:Person {name:row.person})
  CREATE (p)-[:ACTED_IN {roles:split(r.roles)} ]->(m);








CREATE (:Person {name:row.name, born: toInt(row.born)});



























LOAD CSV WITH HEADERS FROM "file:///groups.csv" AS row
MERGE (group:Group { id:row.id })
ON CREATE SET group.name = row.name,
              group.urlname = row.urlname,
              group.rating = toint(row.rating),
              group.created = toint(row.created)

CREATE CONSTRAINT ON (g:Group)
ASSERT g.id IS UNIQUE;

CREATE CONSTRAINT ON (t:Topic)
ASSERT t.id IS UNIQUE;

LOAD CSV WITH HEADERS FROM "file:///groups_topics.csv"
AS row
MERGE (topic:Topic {id: row.id})
ON CREATE SET topic.name = row.name,
              topic.urlkey = row.urlkey;

              LOAD CSV WITH HEADERS FROM "file:///groups_topics.csv"
              AS row
              MATCH (topic:Topic {id: row.id})
              MATCH (group:Group {id: row.groupId})
              MERGE (group)-[:HAS_TOPIC]->(topic)
;

MATCH (group:Group {name: "Neo4j - London User Group"})
      -[:HAS_TOPIC]->(topic)<-[:HAS_TOPIC]-(otherGroup)
RETURN otherGroup.name,
       COUNT(topic) AS topicsInCommon,
       COLLECT(topic.name) AS topics
ORDER BY topicsInCommon DESC, otherGroup.name
LIMIT 10;

LOAD CSV WITH HEADERS FROM "file:///path/to/members.csv" AS row
WITH DISTINCT row.id AS id, row.name AS name
MERGE (member:Member {id: id})
ON CREATE SET member.name = name;

LOAD CSV WITH HEADERS FROM "file:///members.csv" AS row
MATCH (member:Member {id: row.id})
MATCH (group:Group {id: row.groupId})
MERGE (member)-[m:MEMBER_OF]->(group)
SET m.joined = toint(row.joined);

MATCH (member:Member {name: "Mark Needham"})
MATCH (group:Group {name: "Neo4j - London User Group"})
       -[:HAS_TOPIC]->(topic)<-[:HAS_TOPIC]-(otherGroup:Group)
RETURN otherGroup.name,
       COUNT(topic) AS topicsInCommon,
       EXISTS((member)-[:MEMBER_OF]->(otherGroup))
       AS alreadyMember,
       COLLECT(topic.name) AS topics
ORDER BY topicsInCommon DESC
LIMIT 10;

MATCH (group:Group {name: "Neo4j - London User Group"})
       -[:HAS_TOPIC]->(topic)<-[:HAS_TOPIC]-(otherGroup:Group)
WHERE NOT( (:Member {name: "Mark Needham"})
            -[:MEMBER_OF]->(otherGroup) )
RETURN otherGroup.name,
       COUNT(topic) AS topicsInCommon,
       COLLECT(topic.name) AS topics
ORDER BY topicsInCommon DESC
LIMIT 10;

MATCH (member:Member {name: "Mark Needham"})
      -[:INTERESTED_IN]->(topic),
      (member)-[:MEMBER_OF]->(group)-[:HAS_TOPIC]->(topic)

WITH member, topic, COUNT(*) AS score
MATCH (topic)<-[:HAS_TOPIC]-(otherGroup)
WHERE NOT (member)-[:MEMBER_OF]->(otherGroup)
RETURN otherGroup.name,
       COLLECT(topic.name),
       SUM(score) as score
ORDER BY score DESC;

MATCH (m:Member {name: "Jonny Cheetham"})
MATCH (m)-[:MEMBER_OF]->(group)-[:HAS_TOPIC]->(topic)

WITH m, topic, COUNT(*) AS times
WHERE times > 3

MERGE (m)-[:INTERESTED_IN]->(topic);

WITH 24.0*60*60*1000 AS oneDay
MATCH (member:Member {name: "Mark Needham"}),
      (member)-[:MEMBER_OF]->(group),
      (group)-[:HOSTED_EVENT]->(futureEvent)
WHERE futureEvent.time >= timestamp()
RETURN group.name, futureEvent.name,
       round((futureEvent.time - timestamp()) / oneDay) AS days
ORDER BY days
LIMIT 10;

WITH 24.0*60*60*1000 AS oneDay

MATCH (member:Member {name: "Mark Needham"})
MATCH (futureEvent:Event) WHERE timestamp() < futureEvent.time < (timestamp() + 7 * oneDay)
MATCH (futureEvent)<-[:HOSTED_EVENT]-(group)

RETURN group.name,
       futureEvent.name,
       EXISTS((group)<-[:MEMBER_OF]-(member)) AS isMember,
       round((futureEvent.time - timestamp()) / oneDay) AS days
ORDER BY isMember DESC, days;


WITH 24.0*60*60*1000 AS oneDay
MATCH (member:Member {name: "Mark Needham"})
MATCH (futureEvent:Event) WHERE timestamp() < futureEvent.time < (timestamp() + 7 * oneDay)
MATCH (futureEvent)<-[:HOSTED_EVENT]-(group)

WITH oneDay, group, futureEvent, member, EXISTS((group)<-[:MEMBER_OF]-(member)) AS isMember
OPTIONAL MATCH (member)-[rsvp:RSVPD]->(pastEvent)<-[:HOSTED_EVENT]-(group)
WHERE pastEvent.time < timestamp()

RETURN group.name,
       futureEvent.name,
       isMember,
       COUNT(rsvp) AS previousEvents,
       round((futureEvent.time - timestamp()) / oneDay) AS days
ORDER BY days, previousEvents DESC;

WITH 24.0*60*60*1000 AS oneDay
MATCH (member:Member {name: "Mark Needham"})
MATCH (futureEvent:Event) WHERE timestamp() < futureEvent.time < (timestamp() + 7 * oneDay)
MATCH (futureEvent)<-[:HOSTED_EVENT]-(group)

WITH oneDay, group, futureEvent, member, EXISTS((group)<-[:MEMBER_OF]-(member)) AS isMember
OPTIONAL MATCH (member)-[rsvp:RSVPD]->(pastEvent)<-[:HOSTED_EVENT]-(group)
WHERE pastEvent.time < timestamp()

WITH oneDay, group, futureEvent, member, isMember, COUNT(rsvp) AS previousEvents
OPTIONAL MATCH (futureEvent)<-[:HOSTED_EVENT]-()-[:HAS_TOPIC]->(topic)<-[:INTERESTED_IN]-(member)

RETURN group.name, futureEvent.name, isMember, previousEvents,
       COUNT(topic) AS topics, round((futureEvent.time - timestamp()) / oneDay) AS days
ORDER BY days,previousEvents DESC, topics DESC;

MATCH (me:Member)-[:RSVPD]->()<-[:RSVPD]-(otherPerson)
WHERE me.name = 'Mark Needham'
WITH otherPerson, COUNT(*) AS commonEvents
ORDER BY commonEvents DESC
LIMIT 10
RETURN otherPerson.name, commonEvents;

CALL apoc.periodic.iterate(
  "MATCH (m:Member) WHERE size( (m)-[:RSVPD]->() ) >= 3 RETURN m",
  "WITH {m} as m
   MATCH (m)-[:RSVPD]->(event)<-[:RSVPD]-(m2)
   WITH m, m2, COUNT(*) AS times
   WHERE times >= 3
   MERGE (m)-[:FRIENDS]-(m2)",
  {batchSize:10000, parallel:true})



WITH 24.0*60*60*1000 AS oneDay
MATCH (member:Member {name: "Mark Needham"})
MATCH (futureEvent:Event) WHERE timestamp() < futureEvent.time < (timestamp() + 7 * oneDay)
MATCH (futureEvent)<-[:HOSTED_EVENT]-(group)

WITH oneDay, group, futureEvent, member, EXISTS((group)<-[:MEMBER_OF]-(member)) AS isMember
OPTIONAL MATCH (member)-[rsvp:RSVPD]->(pastEvent)<-[:HOSTED_EVENT]-(group)
WHERE pastEvent.time < timestamp()

WITH oneDay, group, futureEvent, member, isMember, COUNT(rsvp) AS previousEvents
OPTIONAL MATCH (futureEvent)<-[:HOSTED_EVENT]-()-[:HAS_TOPIC]->(topic)<-[:INTERESTED_IN]-(member)

WITH oneDay, group, futureEvent, member, isMember, previousEvents, COUNT(topic) AS topics
OPTIONAL MATCH (member)-[:FRIENDS]-(:Member)-[rsvpYes:RSVPD]->(futureEvent)

RETURN group.name, futureEvent.name, isMember, round((futureEvent.time - timestamp()) / oneDay) AS days,
       previousEvents, topics, COUNT(rsvpYes) AS friendsGoing
ORDER BY days, friendsGoing DESC, previousEvents DESC
LIMIT 15;


MATCH (m1:Member) WHERE m1.name = 'Mark Needham'
MATCH (m1)-[friendship:FRIENDS]-(m2:Member)
WITH m1, m2, friendship
MATCH (m1)-[:RSVPD]->(commonEvent)<-[:RSVPD]-(m2)
WITH m1, m2, COUNT(commonEvent) AS commonEvents
WITH m1, m2, commonEvents, SIZE((m1)-[:RSVPD]->()) AS m1Rsvps, SIZE((m2)-[:RSVPD]->()) AS m2Rsvps
RETURN m1.name, m2.name, commonEvents, m1Rsvps, m2Rsvps,
       (2 * 1.0 * commonEvents) / (m1Rsvps + m2Rsvps) AS diceSimilarity
ORDER BY diceSimilarity DESC
LIMIT 10;

CALL apoc.periodic.iterate(
 "MATCH (m:Member) WHERE size( (m)-[:RSVPD]->() ) >= 3 RETURN m",
 "WITH {m} as m
  MATCH (m)-[friendship:FRIENDS]-(m2:Member)
  WITH m, m2, friendship
  MATCH (m1)-[:RSVPD]->(commonEvent)<-[:RSVPD]-(m2)
  WITH m1, m2, friendship, COUNT(commonEvent) AS commonEvents
  WITH m1, m2, friendship, commonEvents, SIZE((m1)-[:RSVPD]->()) AS m1Rsvps,
       SIZE((m2)-[:RSVPD]->()) AS m2Rsvps
  WITH m1, m2, friendship, commonEvents, m1Rsvps, m2Rsvps,
       (2 * 1.0 * commonEvents) / (m1Rsvps + m2Rsvps) AS diceSimilarity
  SET friendship.score = diceSimilarity",
  {batchSize:10000, parallel:true});


  WITH 24.0*60*60*1000 AS oneDay
  MATCH (member:Member {name: "Mark Needham"})
  MATCH (futureEvent:Event) WHERE timestamp() < futureEvent.time < (timestamp() + 7 * oneDay)
  MATCH (futureEvent)<-[:HOSTED_EVENT]-(group)

  WITH oneDay, group, futureEvent, member, EXISTS((group)<-[:MEMBER_OF]-(member)) AS isMember
  OPTIONAL MATCH (member)-[rsvp:RSVPD]->(pastEvent)<-[:HOSTED_EVENT]-(group)
  WHERE pastEvent.time < timestamp()

  WITH oneDay, group, futureEvent, member, isMember, COUNT(rsvp) AS previousEvents
  OPTIONAL MATCH (futureEvent)<-[:HOSTED_EVENT]-()-[:HAS_TOPIC]->(topic)<-[:INTERESTED_IN]-(member)

  WITH oneDay, group, futureEvent, member, isMember, previousEvents, COUNT(topic) AS topics
  OPTIONAL MATCH (member)-[f:FRIENDS]-(:Member)-[rsvpYes:RSVPD]->(futureEvent) WHERE f.score > 0.2

  RETURN group.name, futureEvent.name, isMember, round((futureEvent.time - timestamp()) / oneDay) AS days,
         previousEvents, topics, COUNT(rsvpYes) AS friendsGoing
  ORDER BY days, friendsGoing DESC, previousEvents DESC
  LIMIT 15;

  CALL apoc.scoring.pareto(1, 5, 10, 8)
  value
  9.238538424513647;

  CALL apoc.scoring.existence(5, false)
  value
  0;

  WITH 24.0*60*60*1000 AS oneDay
  MATCH (member:Member {name: "Mark Needham"})
  MATCH (futureEvent:Event) WHERE timestamp() < futureEvent.time < (timestamp() + 7 * oneDay)
  MATCH (futureEvent)<-[:HOSTED_EVENT]-(group)

  WITH oneDay, group, futureEvent, member, EXISTS((group)<-[:MEMBER_OF]-(member)) AS isMember
  OPTIONAL MATCH (member)-[rsvp:RSVPD]->(pastEvent)<-[:HOSTED_EVENT]-(group)
  WHERE pastEvent.time < timestamp()

  WITH oneDay, group, futureEvent, member, isMember, COUNT(rsvp) AS previousEvents
  OPTIONAL MATCH (futureEvent)<-[:HOSTED_EVENT]-()-[:HAS_TOPIC]->(topic)<-[:INTERESTED_IN]-(member)

  WITH oneDay, group, futureEvent, member, isMember, previousEvents, COUNT(topic) AS topics
  OPTIONAL MATCH (member)-[:FRIENDS]-(:Member)-[rsvpYes:RSVPD]->(futureEvent)

  WITH oneDay, group, futureEvent, member, isMember, previousEvents, topics, COUNT(rsvpYes) AS friendsGoing

  CALL apoc.scoring.pareto(1, 5, 10, topics) YIELD value AS topicScore
  CALL apoc.scoring.pareto(1, 3, 10, previousEvents) YIELD value AS previousEventsScore
  CALL apoc.scoring.pareto(1, 5, 20, friendsGoing) YIELD value AS friendsGoingScore
  CALL apoc.scoring.existence(5, isMember) YIELD value AS membershipScore

  RETURN group.name, futureEvent.name, isMember, round((futureEvent.time - timestamp()) / oneDay) AS days,
         previousEvents, topics, friendsGoing, topicScore + previousEventsScore + friendsGoingScore + membershipScore AS score
  ORDER BY score DESC
  LIMIT 15;

  LOAD CSV WITH HEADERS FROM "(file|http)://" AS row

  MATCH  (:Label {property: row.header})
  CREATE (:Label {property: row.header})
  MERGE  (:Label {property: row.header});

  LOAD CSV WITH HEADERS
  FROM "file:///transfers.csv"
  AS row
  RETURN COUNT(*)
;

LOAD CSV WITH HEADERS
FROM "file:///transfers.csv"
AS row
RETURN row
LIMIT 1;

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///transfers.csv" AS row
CREATE (player:Player {
    id: row.playerUri,
    name: row.playerName,
    position: row.playerPosition
})
;

CREATE CONSTRAINT ON (player:Player)
ASSERT player.id IS UNIQUE;


USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///transfers.csv" AS row
MERGE (player:Player {id: row.playerUri})
ON CREATE SET player.name =  row.playerName,
              player.position = row.playerPosition;


              USING PERIODIC COMMIT
              LOAD CSV WITH HEADERS FROM "file:///transfers.csv" AS row
              MERGE (club:Club {id: row.sellerClubUri})
              ON CREATE SET club.name = row.sellerClubName,
                            club.country = row.sellerClubCountry;

                            USING PERIODIC COMMIT
                            LOAD CSV WITH HEADERS FROM "file:///transfers.csv" AS row
                            MERGE (club:Club {id: row.buyerClubUri})
                            ON CREATE SET club.name = row.buyerClubName,
                                          club.country = row.buyerClubCountry;

LOAD CSV WITH HEADERS FROM "file:///transfers.csv" AS row
MATCH (player:Player {id: row.playerUri})
MATCH (source:Club {id: row.sellerClubUri})
MATCH (destination:Club {id: row.buyerClubUri})
MERGE (t:Transfer {id: row.transferUri})
ON CREATE SET t.season = row.season, t.rank = row.transferRank,
              t.fee = row.transferFee
MERGE (t)-[:OF_PLAYER { age: row.playerAge }]->(player)
MERGE (t)-[:FROM_CLUB]->(source)
MERGE (t)-[:TO_CLUB]->(destination);

CREATE CONSTRAINT ON (club:Club)
ASSERT EXISTS(club.name);

CREATE CONSTRAINT ON ()-[player:OF_PLAYER]-() ASSERT exists(player.age);

MATCH (player:Player { name: "Cristiano Ronaldo" })
RETURN player;


MATCH (from:Club)<-[:FROM_CLUB]-(transfer:Transfer)-[:TO_CLUB]->(to:Club),
      (transfer)-[:OF_PLAYER]->(player)
WHERE from.name = "Tottenham Hotspur" AND to.name = "Manchester United"
RETURN player.name, transfer.numericFee, transfer.season;


USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:///transfers.csv" AS row
MATCH (player:Player {id: row.playerUri})
SET player.nationality = row.playerNationality;

MATCH (to:Club)<-[:TO_CLUB]-(t:Transfer)-[:FROM_CLUB]-(from:Club),
      (t)-[:OF_PLAYER]->(player:Player)
WHERE to.country = "England" AND from.country = "England"
AND player.nationality = "England"
RETURN player.name, from.name, to.name, t.numericFee, t.season
ORDER BY t.numericFee DESC
LIMIT 10;

LOAD CSV WITH HEADERS
FROM "file:///confederations.csv" AS row
MERGE (c:Confederation {id: row.urlName})
ON CREATE
SET c.shortName = row.shortName,
    c.region = row.region,
    c.name = row.name;

    LOAD CSV WITH HEADERS FROM "file:///countries.csv"
    AS row
    MATCH (conf:Confederation {id: row.confederation })
    MERGE (country:Country {id: row.countryCode})
    ON CREATE SET country.name = row.country
    MERGE (country)-[:PART_OF]->(conf);

    MATCH (club:Club)
    MATCH (country:Country {name: club.country})
    MERGE (club)-[:PART_OF]->(country)
    REMOVE club.country;

    MATCH (player:Player)
    MATCH (country:Country {name: player.nationality})
    MERGE (player)-[:PLAYS_FOR]->(country)
    REMOVE player.nationality;

    MATCH (to:Club)<-[:TO_CLUB]-(t:Transfer)-[:FROM_CLUB]-(from:Club),
          (t)-[:OF_PLAYER]->(player:Player)-[:PLAYS_FOR]->(country:Country),
          (to)-[:PART_OF]->(country)<-[:PART_OF]-(from)
    WHERE country.name = "England"
    RETURN player.name, from.name, to.name, t.numericFee, t.season
    ORDER BY t.numericFee DESC
    LIMIT 10;


    MATCH (to:Club)<-[:TO_CLUB]-(t:Transfer)-[:FROM_CLUB]-(from:Club),
          (t)-[:OF_PLAYER]->(player:Player),
          (from)-[:PART_OF*2]->(:Confederation {id: "afc"}),
          (to)-[:PART_OF*2]->(:Confederation {id: "uefa"})
    RETURN player.name, from.name, to.name, t.numericFee, t.season
    ORDER BY t.numericFee DESC
    LIMIT 10;

MATCH (:Topic {name: "Neo4j"})-[:NARROWER_THAN]->(parent)<-[:NARROWER_THAN]-(similar)
RETURN similar.name, COUNT(*) AS times, COLLECT(parent.name) AS parents
ORDER BY times DESC









;

MATCH (topic:Topic {name: "Neo4j"})
MATCH (topic)-[:NARROWER_THAN]->({name: "NoSQL"})<-[:NARROWER_THAN]-(similar)
RETURN similar.name
ORDER BY similar.name
LIMIT 10;


MATCH (topic:Topic)
WITH topic, size((topic)<-[:HAS_TOPIC]-()) as ct
MATCH (topic)<-[:HAS_TOPIC]-(group)-[:HAS_TOPIC]->(relatedTopic)
WITH topic, relatedTopic, tofloat(count(group))/ct AS cooccurenceIndex
CREATE (topic)-[:CO_OCCURS {index: cooccurenceIndex }]->(relatedTopic);

// step2 : infer same-as
MATCH (topic1)-[co1:CO_OCCURS {index : 1}]->(topic2)-[co2:CO_OCCURS { index: 1}]->(topic1)
WHERE ID(topic1) > ID(topic2)
MERGE (topic1)-[:SAME_AS]->(topic2);

// step3: infer narrower-than
MATCH (topic1)-[co1:CO_OCCURS]->(topic2), (topic2)-[co2:CO_OCCURS]->(topic1)
WHERE ID(topic1) > ID(topic2) AND co1.index = 1 and co2.index < 1
MERGE (topic1)-[:NARROWER_THAN]->(topic2);

// step4: reduce narrower-than taxonomy to delete indirect relationships
MATCH (topic1)-[:NARROWER_THAN]->(topic2)-[:NARROWER_THAN]->(topic3), (topic1)-[d:NARROWER_THAN]->(topic3)
DELETE d;


// find the taxonomy around Neo4j
MATCH path = (n:Topic)-[:NARROWER_THAN*]-()
WHERE n.name contains "Neo4j"
RETURN path;

CREATE (m:Movie {title:'Mystic River', released:2003})
RETURN m;

MATCH (m:Movie {title: 'Mystic River'})
SET m.tagline = 'We bury our sins here, Dave. We wash them clean.' RETURN m;


MATCH (m:Movie {title: 'Mystic River'})
MATCH (p:Person {name: 'Kevin Bacon'})
CREATE (p)-[r:ACTED_IN {roles: ['Sean']}]->(m)
RETURN p, r, m;

MERGE (p:Person {name: 'Tom Hanks'})
RETURN p;

MERGE (p:Person {name: 'Tom Hanks', oscar: true})
RETURN p;

MERGE (p:Person {name: 'Tom Hanks'})
SET p.oscar = true
RETURN p;

MERGE (p:Person {name: 'Tom Hanks'})-[:ACTED_IN]->(m:Movie {title: 'The Terminal'})
RETURN p, m;

MERGE (p:Person {name: 'Tom Hanks'})
MERGE (m:Movie {title: 'The Terminal'})
MERGE (p)-[r:ACTED_IN]->(m)
RETURN p, r, m;

MERGE (p:Person {name: 'Your Name'})
  ON CREATE SET p.created = timestamp(),
                p.updated = 0
  ON MATCH SET p.updated = p.updated + 1
RETURN p.created, p.updated;














































































