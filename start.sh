#!/bin/sh
# Auto Update & Run PaperMC server script

# Settings
version="1.16.5"

initMem="1500M"
maxMem="1500M"

launchoptions="-Xms$initMem -Xmx$maxMem"


# Updating
url="https://papermc.io/api/v1/paper/$version/latest"

echo "Checking for newer build..."
build=$(curl -s "$url" | sed -E 's/.*"build":"?([0-9]+)"?.*/\1/')
jar="paper-$version-$build.jar"

[ -f "$jar" ] && echo "Already latest build." || \
{
    [[ "$jar" == *error* ]] && echo "no such version: $version" && exit 1
    
    echo "Downloading $jar..."
    curl -#o "$jar" "$url/download"
}


# Launching
echo "Starting server..."
java $launchoptions -jar "$jar" nogui
