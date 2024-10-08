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
    cp -r /APMCServer/* $datadir 
    cp /run.sh $datadir/APMCServer/
fi

echo -n "$APMC" > $datadir/APMCServer/APData/apmc.apmc

cd $datadir/APMCServer

./run.sh