#!/bin/sh
# Auto Update & Run PaperMC server script

# Settings
version="1.16.4"

initMem="4G"
maxMem="4G"

launchoptions="-Xms$initMem -Xmx$maxMem"


# Updating
url="https://papermc.io/api/v1/paper/$version/latest"

echo "Checking for newer build..."
build=$(curl -s $url | grep -o "\"build\":\"\?[0-9]\+" | grep -o "[0-9]\+")

[ -f "./paper-$version-$build.jar" ] && \
echo "Already latest build." || {
    echo "Downloading paper-$version-$build.jar...";
    wget -q "$url/download" -O "./paper-$version-$build.jar";
}


# Launching
echo "Starting server..."
java $launchoptions -jar "./paper-$version-$build.jar" nogui
