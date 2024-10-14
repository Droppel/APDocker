#!/usr/bin/env sh
# Forge requires a configured set of both JVM and program arguments.
# Add custom JVM arguments to the user_jvm_args.txt
# Add custom program arguments {such as nogui} to this file in the next line before the "$@" or
#  pass them to this script directly

datadir="/data"

if [ -z "${DATADIR}" ]; then
    datadir=$DATADIR
fi

if [ ! "$(ls -A $datadir)" ]; then
    echo "Creating data dir at $datadir"
    mkdir $datadir
    chmod 777 $datadir
    cp -r /Server/factorio/* $datadir
    # $datadir/bin/x64/factorio --create $datadir/saves/save.zip
fi

mkdir -p $datadir/data
echo -n "$WHITELIST" > $datadir/data/server-whitelist.json
mkdir -p $datadir/mods
mkdir -p $datadir/saves
cp mods/* $datadir/mods/
cp -r Archipelago/* $datadir/
cp host.yaml $datadir/Archipelago/host.yaml
cp server-settings.json $datadir/data/server-settings.json

cd $datadir/Archipelago

echo "Starting Factorio"

{ sleep 15; echo "/connect archipelago.gg:49504"; } | ./ArchipelagoFactorioClient --nogui --server-settings ../data/server-settings.json --use-server-whitelist --server-whitelist ../data/server-whitelist.json --mod-directory ../mods