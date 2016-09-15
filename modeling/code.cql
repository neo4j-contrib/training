LOAD CSV     // load csv data
WITH HEADERS // optionally use first header row as keys in "row" map
FROM "url"   // file:// URL relative to $NEO4J_HOME/import or http://
AS row       // return each row of the CSV as list of strings or map

// ... rest of the Cypher statement ...


