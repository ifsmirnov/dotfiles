#!/bin/bash
actual=$(ssh -V 2> >(sed 's,^[^0-9]*,,;s,[^\.0-9].*,,'))
expected=$1
[ -n "$expected" ] || { echo "Specify version" 2>&1; exit 1 ;}

[ $(bc <<<"$actual >= $expected") == 1 ]
