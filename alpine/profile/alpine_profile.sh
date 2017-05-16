#!/bin/sh

export CHARSET=UTF-8
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

for script in /etc/profile.d/*.sh ; do
  if [ -r $script ] ; then
    . $script
  fi
done
