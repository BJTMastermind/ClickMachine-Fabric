#!/bin/bash

if [[ -d "build" ]] then rm -r "build" fi
./gradlew eclipse --no-daemon
./gradlew genEclipseRuns --no-daemon
PROJNAME=${PWD##*/}
rm "$PROJNAME-Client.launch"
rm "$PROJNAME-Server.launch"
rm "$PROJNAME-Data.launch"
mv "./runClient.launch" "./$PROJNAME-Client.launch"
mv "./runServer.launch" "./$PROJNAME-Server.launch"
mv "./runData.launch" "./$PROJNAME-Data.launch"

modid=$(grep "modid=" "gradle.properties" | cut -d '=' -f2)

cd src/main/resources
mv "./modid.mixins.json" "./$modid.mixins.json"
cd data
mv "modid" "$modid"
cd ../assets
mv "modid" "$modid"
cd ../../../..
./gradlew processResources --no-daemon