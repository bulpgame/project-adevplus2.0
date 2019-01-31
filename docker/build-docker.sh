#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/..

DOCKER_IMAGE=${DOCKER_IMAGE:-adevplus20pay/adevplus20d-develop}
DOCKER_TAG=${DOCKER_TAG:-latest}

BUILD_DIR=${BUILD_DIR:-.}

rm docker/bin/*
mkdir docker/bin
cp $BUILD_DIR/src/adevplus20d docker/bin/
cp $BUILD_DIR/src/adevplus20-cli docker/bin/
cp $BUILD_DIR/src/adevplus20-tx docker/bin/
strip docker/bin/adevplus20d
strip docker/bin/adevplus20-cli
strip docker/bin/adevplus20-tx

docker build --pull -t $DOCKER_IMAGE:$DOCKER_TAG -f docker/Dockerfile docker
