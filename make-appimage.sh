#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q collision | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/dev.geopjr.Collision.svg
export DESKTOP=/usr/share/applications/dev.geopjr.Collision.desktop
export STARTUPWMCLASS=dev.geopjr.Collision # Default to Wayland's wmclass. For X11, GTK_CLASS_FIX will force the wmclass to be the Wayland one.
export GTK_CLASS_FIX=1
export USE_HOST_DRIVERS_EXPERIMENTAL=1

# Trace and deploy all files and directories needed for the application (including binaries, libraries and others)
quick-sharun /usr/bin/collision

# Turn AppDir into AppImage
quick-sharun --make-appimage
