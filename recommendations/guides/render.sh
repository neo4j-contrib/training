echo "Usage: sh render.sh [publish]"
GUIDES=../../neo4j-guides
# git clone http://github.com/jexp/neo4j-guides $GUIDES

function render {
$GUIDES/run.sh index.adoc index.html +1 "$@"
$GUIDES/run.sh 01_similar_groups_by_topic.adoc 01_similar_groups_by_topic.html +1 "$@"
$GUIDES/run.sh 01_explore_graph_answers.adoc 01_explore_graph_answers.html +1 "$@"
$GUIDES/run.sh 01_explore_graph_answers.adoc answers/1.html +1 "$@"
$GUIDES/run.sh 02_my_similar_groups.adoc 02_my_similar_groups.html +1 "$@"
$GUIDES/run.sh 02_find_yourself_answers.adoc answers/2.html +1 "$@"
$GUIDES/run.sh 03_my_interests.adoc 03_my_interests.html +1 "$@"
$GUIDES/run.sh 03_inferred_answers.adoc answers/3.html +1 "$@"
$GUIDES/run.sh 04_events.adoc 04_events.html +1 "$@"
$GUIDES/run.sh 04_events_answers.adoc answers/4.html +1 "$@"
$GUIDES/run.sh 05_venues.adoc 05_venues.html +1 "$@"
$GUIDES/run.sh 05_venues_import_answers.adoc answers/5a.html +1 "$@"
$GUIDES/run.sh 05_venues_distance_queries_answers.adoc answers/5b.html +1 "$@"
$GUIDES/run.sh 06_rsvps.adoc 06_rsvps.html +1 "$@"
$GUIDES/run.sh 06_my_venues_answers.adoc answers/6.html +1 "$@"
$GUIDES/run.sh 07_procedures.adoc 07_procedures.html +1 "$@"
$GUIDES/run.sh 07_photos_answers.adoc answers/7.html +1 "$@"
$GUIDES/run.sh 08_latent_social_graph.adoc 08_latent_social_graph.html +1 "$@"
$GUIDES/run.sh 08_latent_answers.adoc answers/8.html +1 "$@"
$GUIDES/run.sh 09_scoring.adoc 09_scoring.html +1 "$@"
$GUIDES/run.sh 10_free_for_all.adoc 10_free_for_all.html +1 "$@"
}

# -a env-training is a flag to enable full content, if you comment it out, the guides are rendered minimally e.g. for a presentation
if [ "$1" == "publish" ]; then
  URL=guides.neo4j.com/reco
  render http://$URL -a csv-url=https://raw.githubusercontent.com/neo4j-meetups/modeling-worked-example/master/data/ -a env-training
  s3cmd put --recursive -P *.html img answers s3://${URL}/
  s3cmd put -P index.html s3://${URL}

  URL=guides.neo4j.com/reco/file
  render http://$URL -a env-training -a csv-url=file:///
  s3cmd put --recursive -P *.html img s3://${URL}/
  s3cmd put -P index.html s3://${URL}
  echo "Publication Done"
else
  URL=localhost:8001
# copy the csv files to $NEO4J_HOME/import
  render http://$URL -a csv-url=file:/// -a env-training
  echo "Starting Websever at $URL Ctrl-c to stop"
  python $GUIDES/http.py
fi
