#!/bin/sh

# Install all packages:
apk add --no-cache $(cat $1)
