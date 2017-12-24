#!/bin/bash
set -e

scriptpath=$(cd $(dirname $0); pwd -P)
source "$scriptpath/versions.config"

repo=RPi-Distro/pi-gen
tag=2017-11-29-raspbian-stretch

echo "Cloning $PI_GEN_REPO"
git clone "https://github.com/$PI_GEN_REPO" pi-gen
cd pi-gen
echo "Checkout $PI_GEN_TAG"
git checkout "$PI_GEN_TAG"

echo "Preparing build"
echo IMG_NAME='hypriotos' >config
cp -r ../stage2/ stage2
touch stage3/SKIP
touch stage4/SKIP
rm -f stage4/EXPORT*
touch stage5/SKIP
rm -f stage5/EXPORT*

echo "Build image"
./build-docker.sh
ls -l deploy
