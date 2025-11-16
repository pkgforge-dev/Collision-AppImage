#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q collision | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/dev.geopjr.Collision.svg
export DESKTOP=/usr/share/applications/dev.geopjr.Collision.desktop
export DEPLOY_OPENGL=1
export STARTUPWMCLASS=collision # For Wayland, this is 'dev.geopjr.Collision', so this needs to be changed in desktop file manually by the user in that case until some potential automatic fix exists for this

# Trace and deploy all files and directories needed for the application (including binaries, libraries and others)
quick-sharun /usr/bin/collision

# Turn AppDir into AppImage
quick-sharun --make-appimage
