# Gmod dedicated server image - Murder
This is a Garry's mod murder server image. It is available on [DockerHub](https://hub.docker.com/repository/docker/charlesmarceau3/gmod-murder-docker).

## Important
This docker image is based on [jusito's docker-ttt image](https://github.com/jusito/docker-ttt).
I only modified the gamemode to murder and added some configuration options.


## Preparing the addons
1. Create a **public** workshop collection containing the [Murder gamemode](https://steamcommunity.com/sharedfiles/filedetails/?id=187073946) and the custom maps you want to use.
2. Take note of your collection's ID. You will need it later.


## How to run
```
docker run -d \
 -p 27015:27015/udp \
 -e SERVER_PORT=27015 \
 -e WORKSHOP_COLLECTION_ID=*your_collection_id* \
 -e SERVER_NAME="your server name" \
 -e SERVER_PASSWORD="securepw" \
 -e SERVER_DEFAULT_MAP="md_clue" \
 -v GmodMurderVolume:/home/steam/serverfiles \
 -p 27015:27015/tcp \
 -e SERVER_RCON_PASSWORD="securePW" \
 --name "GmodMurderServer" \
 charlesmarceau3/gmod-murder-server
```

## More documentation
More documentation is available in [jusito's README.md](https://github.com/jusito/docker-ttt/blob/master/README.md).
