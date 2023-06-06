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
  -c              Read from clipboard instead of file.
  -h              Show this help message.
EOF

  exit 1
}

file="$1"
sentences="1"

clipboard=""

while getopts "s:ch" o; do
  case "${o}" in
    s)
      sentences=${OPTARG}

      if ! [[ "$sentences" =~ ^[0-9]+$ ]]; then
        echo "sentences must be a number" 1>&2
        exit 1
      fi

      ;;
    
    c)
      clipboard="1"
      ;;

    *)
      usage
      ;;
  esac
done
shift $((OPTIND-1))

if [ -z "$file" ]; then
  file="/dev/stdin"
fi

if [ "$clipboard" = 1 ]; then
  text=`osascript -e 'the clipboard'`
else
  text=`cat "$file"`
fi

textJson=`jq -RMcs . <<< "$text"`

osascript -e "summarize $textJson in $sentences"
