#!/bin/bash

# Check if we are root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Read the filesystem or default to ntfs
read -p "What filesystem would you like to use? (NTFS) " FS;
if [ -z "$FS" ]; then
   FS="ntfs";
fi

# Read the path to the ISO file.
read -p "What is the path to the ISO file? " ISO;
if [ -z "$ISO" ]; then
   echo "You must specify a path to the ISO file.";
   exit 1;
fi

# Read the mount/partition path.
read -p "What is the path to the mount point or partition? " DEVICE;
if [ -z "$DEVICE" ]; then
   echo "You must specify a path to the mount point or partition.";
   exit 1;
fi

# Decide whether we're in verbose mode.
read -p "Verbose mode? (y/N) " VERBOSE;
if [ -z "$VERBOSE" ]; then
   VERBOSE="n";
fi

# Decide whether we're in debug mode.
read -p "Debug mode? (y/N) " DEBUG;

# Define a list of additional params.
PARAMS="";

# Add `--verbose` to the params if we're in verbose mode.
if [ "$VERBOSE" == "y" ]; then
   PARAMS="$PARAMS --verbose";
fi

# Add `--debug` to the params if we're in debug mode.
if [ "$DEBUG" == "y" ]; then
   PARAMS="$PARAMS --debug";
fi

sudo woeusb --target-filesystem "$FS" --device "$ISO" "$DEVICE" $PARAMS;
exit;
