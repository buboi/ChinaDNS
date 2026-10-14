#!/bin/sh
# Build a static aarch64 (arm64) chinadns for routers such as IPQ807x.
# Needs Docker. Builds from a clean copy of HEAD, output: build/chinadns-aarch64
set -e

cd "$(dirname "$0")"
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT

git archive HEAD | tar x -C "$work"

docker run --rm --platform linux/arm64 -v "$work":/src -w /src alpine:3.20 sh -c '
  apk add -q build-base autoconf automake &&
  ./autogen.sh &&
  ./configure LDFLAGS=-static &&
  make &&
  strip src/chinadns'

mkdir -p build
cp "$work/src/chinadns" build/chinadns-aarch64
file build/chinadns-aarch64
