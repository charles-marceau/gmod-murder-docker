#!/bin/sh

if [ "${DEBUGGING}" = "true" ]; then
	set -o xtrace
fi

set -o errexit
set -o nounset
#./prepareServer.sh: 9: set: Illegal option -o pipefail
#set -o pipefail

# copy lgsm config
mkdir -p "/home/steam/lgsm/config-lgsm/gmodserver/"
cp -f "/home/common.cfg" "/home/steam/lgsm/config-lgsm/gmodserver/common.cfg" # common.cfg should be target, but is wrong, maybe a bug. (gmodserver working)

cd "/home"
echo "[prepareServer.sh]check configurations"
./initConfig.sh
echo "[prepareServer.sh]check murder configurations"
./initConfigMurder.sh
echo "[prepareServer.sh]force workshop download"
./forceWorkshopDownload.sh
echo "[prepareServer.sh]install & mount gamefiles"
./installAndMountAddons.sh
cd "$STEAM_PATH"