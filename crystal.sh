#! /usr/bin/env sh
[ -z $CRYSTAL_PATH ] && export CRYSTAL_PATH=lib:/opt/crystal/src
export LIBRARY_PATH=$LIBRARY_PATH:/opt/crystal/embedded/lib
/opt/crystal/bin/crystal "${@}"
