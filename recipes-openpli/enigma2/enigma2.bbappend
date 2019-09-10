FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

MAINTAINER = "Open Vision Developers"

DEPENDS += "\
	${@bb.utils.contains("MACHINE_FEATURES", "uianimation", "libvugles2-${MACHINE} libgles-${MACHINE}", "", d)} \
	"

RDEPENDS_${PN} += "\
	enigma2-plugin-extensions-pespeedup \
	${@bb.utils.contains("MACHINE_FEATURES", "smallflash", "", "glibc-gconv-cp1250", d)} \
	${@bb.utils.contains("MACHINE_FEATURES", "uianimation", "libvugles2-${MACHINE} libgles-${MACHINE}", "", d)} \
	ntpdate \
	openvision-branding \
	"

RRECOMMENDS_${PN} = "\
	hotplug-e2-helper \
	glibc-gconv-utf-16 \
	${@bb.utils.contains("MACHINE_FEATURES", "smallflash", "", "ofgwrite", d)} \
	python-sendfile \
	virtual/enigma2-mediaservice \
	"

PYTHON_RDEPS += "\
	${@bb.utils.contains("MACHINE_FEATURES", "smallflash", "", "python-imaging", d)} \
	python-process \
	python-pyusb \
	python-service-identity \
	"

inherit upx_compress

PV = "develop+git${SRCPV}"
PKGV = "develop+git${GITPKGV}"

SRC_URI = "git://github.com/OpenVisionE2/enigma2-openvision.git"

EXTRA_OECONF_append += "\
	--with-boxbrand="${BOX_BRAND}" \
	--with-oever="${VISIONVERSION}" \
	${@bb.utils.contains("MACHINE_FEATURES", "bwlcd128", "--with-bwlcd128" , "", d)} \
	${@bb.utils.contains("MACHINE_FEATURES", "bwlcd140", "--with-bwlcd140" , "", d)} \
	${@bb.utils.contains("MACHINE_FEATURES", "bwlcd255", "--with-bwlcd255" , "", d)} \
	${@bb.utils.contains("MACHINE_FEATURES", "colorlcd220", "--with-colorlcd220" , "", d)} \
	${@bb.utils.contains("MACHINE_FEATURES", "colorlcd390", "--with-colorlcd390" , "", d)} \
	${@bb.utils.contains("MACHINE_FEATURES", "colorlcd400", "--with-colorlcd400" , "", d)} \
	${@bb.utils.contains("MACHINE_FEATURES", "colorlcd480", "--with-colorlcd480" , "", d)} \
	${@bb.utils.contains("MACHINE_FEATURES", "colorlcd720", "--with-colorlcd720" , "", d)} \
	${@bb.utils.contains("MACHINE_FEATURES", "colorlcd800", "--with-colorlcd800" , "", d)} \
	${@bb.utils.contains("MACHINE_FEATURES", "hiaccel", "--with-libhiaccel" , "", d)} \
	${@bb.utils.contains("MACHINE_FEATURES", "triaccel", "--with-libtriaccel" , "", d)} \
	${@bb.utils.contains("MACHINE_FEATURES", "uianimation", "--with-libvugles2" , "", d)} \
	${@bb.utils.contains("MACHINE_FEATURES", "osdanimation", "--with-osdanimation" , "", d)} \
	${@bb.utils.contains("MACHINE_FEATURES", "olde2api", "--with-olde2api" , "", d)} \
	"

DESCRIPTION_enigma2-plugin-font-wqy-microhei = "wqy-microhei font supports Chinese EPG"
PACKAGES =+ "enigma2-plugin-font-wqy-microhei"
FILES_enigma2-plugin-font-wqy-microhei = "${datadir}/fonts/wqy-microhei.ttc ${datadir}/fonts/fallback.font"
ALLOW_EMPTY_enigma2-plugin-font-wqy-microhei = "1"

python populate_packages_prepend() {
    enigma2_plugindir = bb.data.expand('${libdir}/enigma2/python/Plugins', d)
    do_split_packages(d, enigma2_plugindir, '^(\w+/\w+)/[a-zA-Z0-9_]+.*$', 'enigma2-plugin-%s', '%s', recursive=True, match_path=True, prepend=True, extra_depends='')
    do_split_packages(d, enigma2_plugindir, '^(\w+/\w+)/.*\.la$', 'enigma2-plugin-%s-dev', '%s (development)', recursive=True, match_path=True, prepend=True, extra_depends='')
    do_split_packages(d, enigma2_plugindir, '^(\w+/\w+)/.*\.a$', 'enigma2-plugin-%s-staticdev', '%s (static development)', recursive=True, match_path=True, prepend=True, extra_depends='')
    do_split_packages(d, enigma2_plugindir, '^(\w+/\w+)/(.*/)?\.debug/.*$', 'enigma2-plugin-%s-dbg', '%s (debug)', recursive=True, match_path=True, prepend=True, extra_depends='')
    enigma2_podir = bb.data.expand('${datadir}/enigma2/po', d)
    do_split_packages(d, enigma2_podir, '^(\w+)/[a-zA-Z0-9_/]+.*$', 'enigma2-locale-%s', '%s', recursive=True, match_path=True, prepend=True, extra_depends="enigma2")
}
