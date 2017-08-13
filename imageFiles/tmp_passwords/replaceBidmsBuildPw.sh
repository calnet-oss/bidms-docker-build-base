#!/bin/sh

FILE="$1"

if [ ! -f "$FILE" ]; then
  echo "$FILE does not exist" > /dev/stderr
  exit 1
fi

password=$(cat /tmp/tmp_passwords/archiva_bidms-build_pw)

sed "s/BIDMS_BUILD_PW/$password/" -i $FILE
