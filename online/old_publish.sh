npm install -g coffee-script
git submodule init
git submodule update
cd cypher-gadget
coffee -c .
cd  ..

IMAGES=dev.assets.neo4j.com/wp-content/uploads/online/graphdatabases
IMG=https://s3.amazonaws.com/$IMAGES

#asciidoctor -a env-training cypher/index_60-Minute-Cypher.adoc -o cypher/index.html
asciidoctor -a image=$IMG -a env-training -T _templates/parts cypher/part*.adoc -D cypher/html/
asciidoctor -a image=$IMG -a env-training -T _templates/wordpress cypher/index_60-Minute-Cypher.adoc -o cypher/index.html
#asciidoctor -a image=$IMG -a env-training -T _templates cypher/index_60-Minute-Cypher.adoc -o cypher/index_wp.html

s3cmd put -P --recursive cypher/*.html cypher/html/*.html cypher/*.js cypher-gadget cypher/img s3://training.neo4j.com/online/graphdatabases/
s3cmd put -P --recursive cypher-gadget s3://training.neo4j.com/online/

s3cmd put -P --recursive cypher/img/ s3://$IMAGES/

IMAGES=dev.assets.neo4j.com/wp-content/uploads/online/production
IMG=https://s3.amazonaws.com/$IMAGES

#asciidoctor -a env-training production/index_neo4j_in_production.adoc -o production/index.html
asciidoctor -a img=$IMG -a env-training -T _templates/wordpress production/index_neo4j_in_production.adoc -o production/index.html
asciidoctor -a img=$IMG -a env-training -T _templates production/index_neo4j_in_production.adoc -o production/index_wp.html
s3cmd put -P --recursive production/index.html production/index_wp.html production/neo4j_in_production/img s3://training.neo4j.com/online/production/
s3cmd put -P --recursive production/neo4j_in_production/img/ s3://$IMAGES/
