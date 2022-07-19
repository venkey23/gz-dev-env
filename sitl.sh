docker run -itd --rm --env-file env.list --network=host ghcr.io/tiiuae/tii-px4-sitl:sha-7e86f65
docker run -itd --rm --env-file env.list --network=host ghcr.io/tiiuae/tii-micrortps-agent:sha-cccdcbc-1
docker run -itd --rm --env-file env.list --network=host ghcr.io/tiiuae/tii-octomap-server2:sha-ed55cc2-1
docker run -itd --rm --env-file env.list --network=host ghcr.io/tiiuae/tii-rplidar:sha-3c21ad7