#!/bin/bash
# -*- coding: utf-8, tab-width: 2 -*-

function all () {
  export LANG{,UAGE}=en_US.UTF-8  # make error messages search engine-friendly
  local SELFPATH="$(readlink -m -- "$BASH_SOURCE"/..)"
  cd -- "$SELFPATH" || return $?

  ./cmp.native.sh || return $?
  nodemjs cmp.mjs || return $?

  echo '+OK all tests passed.'
}

all "$@"; exit $?
