echo "Usage: sh render.sh [publish]"
GUIDES=../../neo4j-guides
# git clone http://github.com/jexp/neo4j-guides $GUIDES

function render {
  $GUIDES/run.sh guides.adoc index.html +1 "$@"
  $GUIDES/run.sh basics.adoc basics.html +1 "$@"
  $GUIDES/run.sh advanced.adoc advanced.html +1 "$@"
  $GUIDES/run.sh import.adoc import.html +1 "$@"
  $GUIDES/run.sh movies.adoc movies.html +1 "$@"
}

# -a env-training is a flag to enable full content, if you comment it out, the guides are rendered minimally e.g. for a presentation
URL=localhost:8001
# copy the csv files to $NEO4J_HOME/import
render http://$URL -a csv-url=file:/// -a env-training
echo "Starting Websever at $URL Ctrl-c to stop"
python $GUIDES/http-server.py
