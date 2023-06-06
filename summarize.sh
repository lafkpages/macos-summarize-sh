#!/usr/bin/env bash

if ! command -v osascript &> /dev/null; then
  echo "osascript could not be found" 1>&2
  exit 1
fi

if ! command -v jq &> /dev/null; then
  echo "jq could not be found" 1>&2
  exit 1
fi

usage() {
  echo "Usage: $0 [...options] [file]" 1>&2
  echo

  cat <<EOF
If no file is specified, will read from stdin. Otherwise, will read file.

Options:
  -s [sentences]  Number of sentences to summarize to. Defaults to 1.
  -h              Show this help message.
EOF

  exit 1
}

sentences="1"

while getopts "s:h" o; do
  case "${o}" in
    s)
      sentences=${OPTARG}

      if ! [[ "$sentences" =~ ^[0-9]+$ ]]; then
        echo "sentences must be a number" 1>&2
        exit 1
      fi

      ;;
    *)
      usage
      ;;
  esac
done
shift $((OPTIND-1))

file="$1"

if [ -f "$file" ]; then
  text=`cat "$file"`
else
  text=`cat <&0`
fi

textJson=`jq -RMcs . <<< "$text"`

osascript -e "summarize $textJson in $sentences"
