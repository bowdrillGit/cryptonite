#! /bin/bash

diff -x '*.in' -x '*.o' -x '*.lo' -x '*.1' -ur ${ANDROID_HOME}/encfs-1.7.4/encfs ./encfs-1.7.4/encfs > encfs-android.patch.new
