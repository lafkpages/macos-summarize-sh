#!/usr/bin/env bash

if ! command -v osascript &> /dev/null; then
  echo "osascript could not be found"
  exit 1
fi

echo "Sumarize here"
