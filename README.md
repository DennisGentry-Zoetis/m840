
This is an attempt to build an image for the Portwell m840 using kirkstone.

I started with the README in meta-m840-imx8mp-kirkstone, and added the repos listed
as dependencies as git submodules, fetched, and updated them.

I sourced poky/oe-environment

Then I did:
bitbake-layers add-layer meta-m840-imx8mp-kirkstone
