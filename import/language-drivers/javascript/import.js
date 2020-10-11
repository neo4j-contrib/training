const neo4j = require('neo4j-driver');
const password = "neo";

const driver = neo4j.driver("bolt://localhost:7687", neo4j.auth.basic("neo4j", password));

const query = `
MERGE (p1:Person {name: $person1 })
MERGE (p2:Person {name: $person2 })
MERGE (p1)-[:KNOWS]->(p2)
`

function importData(person1, person2) {
    const session = driver.session();
    const resultPromise = session.run(query, {person1: person1, person2: person2} );
    resultPromise.then(result => {
      console.log(result.summary.counters);

      session.close();
      // on application exit:
      driver.close();
    });
}

if(process.argv.length < 4) {
    console.log("Usage: node import.js name1 name2")
    process.exit(1);
} else {
    importData(process.argv[2], process.argv[3])
}
