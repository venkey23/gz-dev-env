#!/bin/bash

# Creates gz- directory structure for gzserver containing world and model data

WORLD_IMAGE="ghcr.io/tiiuae/tii-gz-world-empty:1.0.0-rc.1"
MODEL_IMAGE="ghcr.io/tiiuae/tii-gz-model-holybro-x500:1.0.0-rc.1"

rm -rf gz-world/
rm -rf gz-models/
rm -rf gz-plugins/
mkdir gz-world
mkdir gz-models
mkdir gz-plugins
mkdir gz-models/model

docker pull $WORLD_IMAGE
docker pull $MODEL_IMAGE

docker create --name tii-gz-temp-world $WORLD_IMAGE
docker create --name tii-gz-temp-model $MODEL_IMAGE

docker cp tii-gz-temp-world:/data/worlds/ gz-world
docker cp tii-gz-temp-world:/data/models/. gz-models
docker cp tii-gz-temp-world:/data/plugins/. gz-plugins

docker cp tii-gz-temp-model:/data/. gz-models/model
mv gz-models/model/plugins/* gz-plugins/

docker container rm tii-gz-temp-world
docker container rm tii-gz-temp-model

# Fill mustache data

# model-01 / drone01, px4 hostname = px401
sed -e 's/{{model-directory}}/model/' \
    -e 's/drone-{{model-name}}-svc/px401/' \
    -e 's/{{model-name}}/drone01/' \
    -e 's/{{ model-name }}/drone01/' \
    gz-models/model/model.sdf.mustache > gz-models/model/model-01.sdf

# model-02 / drone02, px4 hostname = px402
sed -e 's/{{model-directory}}/model/' \
    -e 's/drone-{{model-name}}-svc/px402/' \
    -e 's/{{model-name}}/drone02/' \
    -e 's/{{ model-name }}/drone02/' \
    gz-models/model/model.sdf.mustache > gz-models/model/model-02.sdf