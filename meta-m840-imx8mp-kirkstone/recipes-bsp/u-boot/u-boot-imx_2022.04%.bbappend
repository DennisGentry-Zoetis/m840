FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Add TI DP83867 Device Tree and disable USB type-C in u-boot

SRC_URI +=   " \
             file://M840_IMX8MP_uboot.cfg \
             file://m840-imx8mp-kirkstone-uboot.dts \
             "


do_configure:prepend() {
	# Add the M840 u-boot configuration into .config
	sed -i -e 's,CONFIG_USB_TCPC=y,# CONFIG_USB_TCPC is not set,g' ${WORKDIR}/git/configs/imx8mp_evk_defconfig
	cat ${WORKDIR}/M840_IMX8MP_uboot.cfg >> ${WORKDIR}/git/configs/imx8mp_evk_defconfig
}

do_configure:append(){
	# Add the M840 device tree into u-boot configuration
	cp ${WORKDIR}/m840-imx8mp-kirkstone-uboot.dts ${S}/arch/arm/dts/imx8mp-evk.dts
}


