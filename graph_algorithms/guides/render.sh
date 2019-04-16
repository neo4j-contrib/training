#!/bin/bash

echo "Usage: sh render.sh [publish]"
GUIDES=../../neo4j-guides
# git clone http://github.com/jexp/neo4j-guides $GUIDES

function render {
  $GUIDES/run.sh index.adoc index.html +1 "$@"
  $GUIDES/run.sh 01_import.adoc 01_import.html +1 "$@"
  $GUIDES/run.sh 02_path_finding.adoc 02_path_finding.html +1 "$@"
  $GUIDES/run.sh 03_centrality.adoc 03_centrality.html +1 "$@"
  $GUIDES/run.sh 04_community_detection.adoc 04_community_detection.html +1 "$@"

  $GUIDES/run.sh yelp.adoc yelp.html +1 "$@"
  $GUIDES/run.sh 05_yelp_similarity.adoc 05_yelp_similarity.html +1 "$@"
  $GUIDES/run.sh 06_yelp_community_detection.adoc 06_yelp_community_detection.html +1 "$@"
}

# -a env-training is a flag to enable full content, if you comment it out, the guides are rendered minimally e.g. for a presentation
if [ "$1" == "publish" ]; then
  URL=guides.neo4j.com/graph_algorithms
  render https://$URL -a env-training
  s3cmd put --recursive -P *.html img s3://${URL}/
  s3cmd put -P index.html s3://${URL}
  echo "Publication Done"
else
  URL=localhost:8001
# copy the csv files to $NEO4J_HOME/import
  render https://$URL -a env-training
  echo "Starting Websever at $URL Ctrl-c to stop"
  python $GUIDES/http-server.py
  # python -m SimpleHTTPServer
fi
