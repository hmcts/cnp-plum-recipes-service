#!/bin/sh

[ "$TEST_HEATH_URL" == "" ] && echo "Error: cannot find TEST_HEALTH_URL env var." && exit 1
[ "$TEST_URL" == "" ] && echo "Error: cannot find TEST_URL env var." && exit 1
[ "$TASK" == "" ] && echo "Error: cannot find TASK env var. It should be 'smoke' or 'functional'" && exit 1

_healthy="false"

for i in $(seq 0 30)
do
  sleep 10
  wget $TEST_HEALTH_URL
  [ "$?" == "0" ] && _healthy="true" && break
done

[ "$_healthy" != "true" ] && "Error: application does not seem to be running" && exit 2

./gradlew --info --rerun-tasks ${TASK}
