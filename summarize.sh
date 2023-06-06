#!/usr/bin/env bash

if ! command -v osascript &> /dev/null; then
  echo "osascript could not be found"
  exit 1
fi

if ! command -v jq &> /dev/null; then
  echo "jq could not be found"
  exit 1
fi

text=`cat <&0`
textJson=`jq -RMc <<< "$text"`

osascript -e "summarize $textJson"
