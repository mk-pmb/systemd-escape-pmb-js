#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-


function cmp_all () {
  export LANG{,UAGE}=en_US.UTF-8  # make error messages search engine-friendly
  local SELFPATH="$(readlink -m -- "$BASH_SOURCE"/..)"
  cd -- "$SELFPATH" || return $?

  local FILE=
  for FILE in [0-9]*.json; do
    cmp_one_json "$FILE" || return $?$(echo '-ERR native test failed!' >&2)
  done
  echo '+OK cmp.native.sh test passed.'
}


function cmp_one_json () {
  local SPECS=()
  readarray -t SPECS < <(./cmp.json-input.sed -- "$1")
  local LIST=()
  local QUOT='"' KEY= VAL= REC_NUM=0
  local -A EX=()
  for VAL in "${SPECS[@]}"; do
    (( REC_NUM += 1 ))
    echo "# $FILE"
    readarray -t LIST <<<"${VAL//$'\t'/$'\n'}"
    EX=()
    for VAL in "${LIST[@]}"; do
      KEY="${VAL%%:*}"
      VAL="${VAL#*:$QUOT}"
      VAL="${VAL%$QUOT}"
      VAL="$(echo -ne "$VAL:")"
      VAL="${VAL%:}"
      EX[$KEY]="$VAL"
    done
    cmp_one_conv  plain   str             || return $?
    cmp_one_conv  plain   path    --path  || return $?
    if [ "${EX[plain]:0:1}" == / ]; then
      cmp_one_conv  path    plain   --unescape --path   || return $?
    else
      cmp_one_conv  str     plain   --unescape          || return $?
    fi
  done
}


function cmp_one_conv () {
  local A="$1"; shift
  local B="$1"; shift
  echo -n "#   $REC_NUM $A -> $B: "
  local WANT="$(systemd-escape "$@" -- "${EX[$A]}")"
  if [ "${EX[$B]}" == "$WANT" ]; then
    echo "ok"
    return 0
  fi
  echo "FAIL!"
  echo "    have: '${EX[$B]}'"
  echo "    want: '$WANT'"
  return 8
}









cmp_all "$@"; exit $?
