#!/bin/bash

echo "Configuring build/conf"

here="$(basename $PWD)"


if [[ -d build ]]; then
    echo "There's already a build directory.  Continuing."
fi
mkdir -p build
cd build

if [[ -d conf ]]; then
    echo "There's already a conf directory.  Continuing."
fi
mkdir -p conf
cd conf

if [[ -L local.conf ]]; then
    echo "Local.conf is already linked."
else
    ln -s ../../m840-conf/local.conf .
fi


if [[ -L bblayers.conf ]]; then
    echo "Bblayers.conf is already linked.  Continuing."
else
    ln -s ../../m840-conf/bblayers.conf .
fi

cd ..

echo "Ready to build as soon as you set the environment variables."
echo "Run \"source ../poky/oe-init-build-env .\""
