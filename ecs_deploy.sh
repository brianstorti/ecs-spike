#!/usr/bin/env bash

# dependencies: jq and envsubst, but both can be replaced (e.g. by sed and grep/cut)

set -e

source .ecsconfig

TAG=$1
IMAGE=$ECR_REPOSITORY:$TAG

$(aws ecr get-login --no-include-email)

docker build -t $SERVICE .
docker tag $SERVICE $IMAGE
docker push $IMAGE

NEW_REVISION=$(aws ecs register-task-definition --cli-input-json "$(envsubst < task-definition-template.json)" | egrep revision | egrep -o '[0-9]+')
aws ecs update-service --cluster $CLUSTER --service $SERVICE --task-definition $TASK_FAMILY:$NEW_REVISION
