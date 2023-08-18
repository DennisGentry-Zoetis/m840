FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI +=   " \
             file://M840_IMX8MP.cfg \
             file://m840-imx8mp-kirkstone-kernel.dts \
             "

python do_display_banner() {
    bb.plain("***********************************************");
    bb.plain("*                META-M840-BSP                *");
    bb.plain("*    Applying custom kernel configuration     *");
    bb.plain("***********************************************");    
}

addtask display_banner before do_build

do_configure:prepend () {
	# Add the M840 kernel configuration into .config
	cat ${WORKDIR}/M840_IMX8MP.cfg >> ${B}/.config
}

do_configure:append(){
	# Add the MiTwell i.MX8MP module device tree into kernel configuration
	cp ${WORKDIR}/m840-imx8mp-kirkstone-kernel.dts ${S}/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
}
