#!/bin/sh
set -e
pacman -S - < pkglist.txt

echo "Run paru.sh as user"
