#!/bin/sh -x
CWD=$(pwd)
set -e

SRC="crowdsec-firewall-bouncer"

if [ ! -d "${SRC}" ]; then
    echo "source directory does not exists, please 'git clone'"
    exit 1
fi

# Crowdsec has a debian dir but we only want to build nftables
echo "I: Remove original Debian build system"
rm -r "${SRC}/debian"

echo "I: Copy Debian build system"
cp -a debian "${SRC}"

cd "${SRC}"
echo "I: Retrieve version information from Git"
dch -v "1:$(git describe --tags | cut -c2-)" "VyOS build"

# Build Debian Crowdsec package
echo "I: Build VyOS crowdsec Package"
dpkg-buildpackage -us -uc -tc -b
