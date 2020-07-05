pathadd() {
    if [ -d "$1" ] && ! echo $PATH | grep -E -q "(^|:)$1($|:)" ; then
        if [ "$2" = "after" ] ; then
            PATH="$PATH:${1%/}"
        else
            PATH="${1%/}:$PATH"
        fi
    fi
}

pathrm() {
    PATH="$(echo $PATH | sed -e "s;\(^\|:\)${1%/}\(:\|\$\);\1\2;g" -e 's;^:\|:$;;g' -e 's;::;:;g')"
}

pathadd /home/peng/openwrt/xiaomi/mips/mips-mt7621-musl-linux/toolchain/bin
export CC=mipsel-openwrt-linux-musl-gcc
export CXX=mipsel-openwrt-linux-musl-g++
export AR=mipsel-openwrt-linux-musl-ar 
export RANLIB=mipsel-openwrt-linux-musl-ranlib
export LD=mipsel-openwrt-linux-musl-ld
