#!/usr/bin/env bash

# get the name of the primary monitor
PRIMARY_MONITOR=$(xrandr -q | grep " primary" | cut -d' ' -f1)

# get the name of the secondary monitor (first non-primary one)
SECONDARY_MONITOR=$(xrandr -q | grep " connected" | grep -v " primary" | cut -d' ' -f1)

export PRIMARY_MONITOR
export SECONDARY_MONITOR
