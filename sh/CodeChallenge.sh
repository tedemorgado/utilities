#!/usr/bin/env bash

function generateCodeVerifier() {
    local NEW_UUID=`cat /dev/random | LC_ALL=C tr -dc "[:alnum:]" | head -c 128`
    echo -n ${NEW_UUID}
}

function generateCodeChallenge() {
  local codeVerifier=''
  if [[ -n "$1" ]]; then
    codeVerifier="$1"
  else
    codeVerifier=`generateCodeVerifier`
  fi
  local verifierCrypt=`echo -n "$codeVerifier" | openssl dgst -binary -sha256 | openssl base64 -A`
  local verifierBase64UrlEncoded=`encode ${verifierCrypt}`
  echo -n ${verifierBase64UrlEncoded}
}

function getAlgorithm() {
  echo -n "S256"
}

function encode() {
  echo -n "$1" | openssl enc -a -A | tr -d '=' | tr '/+' '_-'
}