#!/bin/bash

# Copy all plugins from old gazebo data container

GAZEBO_DATA_IMAGE="ghcr.io/tiiuae/tii-gazebo-data:tcp_test4"

docker create --name tii-gz-temp-plugins $GAZEBO_DATA_IMAGE

mkdir -p gz-plugins
docker cp tii-gz-temp-plugins:/gazebo-data/plugins/. gz-plugins

docker container rm tii-gz-temp-plugins