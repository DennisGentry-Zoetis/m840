#!/bin/bash

here=$(basename $PWD)
pushd .

image_to_build=m840-image

if [[ $here == "scripts" ]]; then
    cd ..
elif [[ $here == "build" ]]; then
    cd ..
fi

source msg.sh

msg "This script builds a bootable image for the CHEM IU OS."
msg "It's running on $wht$(hostname)."


msg "Creating build/conf."
source set-up-build.sh
# That leaves you in the new build directory; possibly it shouldn't.

msg "Setting environment variables."
source ../poky/oe-init-build-env .

msg "Building."
bitbake -k $image_to_build

# If that succeeded, print location of build products for the noobs
saved_build_status=@?
if [[ ! $saved_build_status ]]; then
  msg "Finding build products."
  bitbake -e $image_to_build &> bitbake.env
  eval $(grep -P '^DEPLOY_DIR_IMAGE=' bitbake.env)
  eval $(grep -P '^DEPLOY_DIR_DEB=' bitbake.env)
  msg "Any successfully built images (.wic.zst and .swu) are in ${wht}${DEPLOY_DIR_IMAGE}/"
  msg "Any successfully built packages (.deb) are within ${wht}${DEPLOY_DIR_DEB}/"
fi

# Put us back where we started.
cd ..

# Exit with bitbake's status so github actions can do the right thing
echo "Saved Build Status Was:"
echo $saved_build_status
