#!/bin/bash

# Check if Limas GPG key exists
if ! gpg --list-keys "Limas" &> /dev/null; then
    echo "Error: Limas GPG key not found. Please import the key first:" >&2
    echo "  cat ~/path/to/pgp-key.private | gpg --import" >&2
    exit 1
fi

echo "Please have your GPG key password ready for signing."
read -p "Press Enter to continue..."

pushd apt-repo
dpkg-scanpackages --multiversion --arch amd64 pool/ > dists/noble/main/binary-amd64/Packages
cat dists/noble/main/binary-amd64/Packages | gzip -9 > dists/noble/main/binary-amd64/Packages.gz
popd

./generate-release.sh > apt-repo/dists/noble/Release

cat apt-repo/dists/noble/Release | gpg --default-key Limas -abs > apt-repo/dists/noble/Release.gpg
cat apt-repo/dists/noble/Release | gpg --default-key Limas -abs --clearsign > apt-repo/dists/noble/InRelease
