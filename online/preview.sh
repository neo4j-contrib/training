echo "Rendering Cypher Training"
asciidoctor -T _templates cypher/index_60-Minute-Cypher.adoc -o cypher/index_wp.html
echo "Rendering Production Training"
asciidoctor -T _templates production/index_neo4j_in_production.adoc -o production/index_wp.html
open cypher/index_wp.html
echo "open production/index_wp.html"