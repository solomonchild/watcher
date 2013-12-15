#!/bin/sh
f=$1
shift
cmd=$*
tmpf="`mktemp /tmp/onchange.XXXX`"
cp "$f" "$tmpf"
trap "rm $tmpf; exit 1" 2
while : ; do
  if [ "$f" -nt "$tmpf" ]; then
    cp "$f" "$tmpf"
    $cmd
    $cmd
  fi
  sleep 2
done
