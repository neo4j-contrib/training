#!/bin/bash
export IMG='https://s3.amazonaws.com/dev.assets.neo4j.com/wp-content/uploads/online/graphdatabases'
echo "Building---"
./build.sh
echo "Publishing---"
python ./publish.py
