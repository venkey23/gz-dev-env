# Gazebo development environment

Example of how to run gzserver and PX4-sitl on local machine without kubernetes and dronsole.

Setup should match the one used in kube-based simulations.

## Setup gazebo data

Fetch world and drone models from data containers to local filesystem:

```bash
$ ./setup-data.sh
```

Creates local directories, which are later mounted to gzserver:

```bash
gz-models/
gz-plugins/
gz-world/
```
Note: source containers are defined in the scripts.

### Old gazebo data container

Plugins can be fetched from old gazebo data container, but this setup won't match dronsole environment:

```bash
$ ./setup-plugins-old.sh
```

## Run single drone setup

Start software:
```bash
$ docker compose -f docker-compose-1.yaml up
```

Add drone model to gzserver:
```bash
$ ./add-drone01.sh
```

## Run two drone setup

Start software:
```bash
$ docker compose up
```

Add drone models to gzserver:
```bash
$ ./add-drone01.sh
$ ./add-drone02.sh
```

## Diagnose stuff

Containers are named:

```bash
# gzserver
gz-dev-env_gzserver_1

# drone01
gz-dev-env_px401_1
gz-dev-env_micrortps02_1

# drone02
gz-dev-env_px401_2
gz-dev-env_micrortps02_2
```

PX4 and micrortps are configured to share the same IP:

```bash
$ docker exec -it gz-dev-env_px402_1 ifconfig
$ docker exec -it gz-dev-env_micrortps02_1 ifconfig
```

Shell into containers:

```bash
$ docker exec -it gz-dev-env_px401_1 /bin/bash
```

Run other containers in the same network:

```bash
$ docker run --rm -it --network gz-dev-env_default --entrypoint /bin/bash ghcr.io/tiiuae/tii-cloud-link:latest
# =>
$ ros2 topic echo /drone01/fmu/vehicle_global_position/out
$ ros2 topic echo /drone02/fmu/vehicle_global_position/out
```
