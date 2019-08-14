#!/usr/bin/env bash
#Credits
#https://raw.githubusercontent.com/Moodstocks/moodstocks-api-clients/master/bash/base64url.sh
function encode {
  echo -n "$1" | openssl enc -a -A | tr -d '=' | tr '/+' '_-'
}

function decode {
  _l=$((${#1} % 4))
  if [ $_l -eq 2 ]; then _s="$1"'=='
  elif [ $_l -eq 3 ]; then _s="$1"'='
  else _s="$1" ; fi
  echo "$_s" | tr '_-' '/+' | openssl enc -d -a -A
}