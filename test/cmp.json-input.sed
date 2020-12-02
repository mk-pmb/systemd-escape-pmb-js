#!/bin/sed -nurf
# -*- coding: UTF-8, tab-width: 2 -*-
/^\{/{
  : read_more
    s~\s+$~~
    s~\s*,$~~
  /\}$/!{N;b read_more}
  s~\s*\}$~~
  s~^\{\s*~~
  s~(^|\n)\s*"([a-z]+)"\s*:\s*~\1\2:~g
  s~\n~\t~g
  p
}
