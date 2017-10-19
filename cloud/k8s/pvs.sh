#!/usr/bin/env bash

set -exuo pipefail

for i in $(seq 0 2); do
  cat <<EOF | kubectl apply -f -
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: datadir-neo4j-core-${i}
  labels:
    app: neo4j
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
EOF

  cat <<EOF | kubectl apply -f -
kind: Pod
apiVersion: v1
metadata:
  name: neo4j-load-data-${i}
  labels:
    app: neo4j-loader
spec:
  volumes:
    - name: datadir-neo4j-core-${i}
      persistentVolumeClaim:
        claimName: datadir-neo4j-core-${i}
  containers:
    - name: neo4j-load-data-${i}
      image: ubuntu
      volumeMounts:
      - name: datadir-neo4j-core-${i}
        mountPath: /data
      command: ["/bin/bash", "-ecx", "while :; do printf '.'; sleep 5 ; done"]


EOF

done;
