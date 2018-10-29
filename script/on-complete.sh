#!/bin/sh
if [ $2 -eq 1 ]; then
	mv "$3" /data
fi
echo [$(date)] $2, $3, $1 "<br>" >> /data/_log.html


DOWNLOAD=/data/downloading # no trailing slash!
COMPLETE=/data/complete # no trailing slash!
LOG=/data/mvcompleted.log
SRC=$3

if [ "$2" == "0" ]; then
  echo `date` "INFO  no file to move for" "$1". >> "$LOG"
  exit 0
fi

while true; do
  DIR=`dirname "$SRC"`
  if [ "$DIR" == "$DOWNLOAD" ]; then
    echo `date` "INFO " "$3" moved as "$SRC". >> "$LOG"
    mv --backup=t "$SRC" "$COMPLETE" >> "$LOG" 2>&1
    exit $?
  elif [ "$DIR" == "/" -o "$DIR" == "." ]; then
    echo `date` ERROR "$3" not under "$DOWNLOAD". >> "$LOG"
    exit 1
  else
    SRC=$DIR
  fi
done
