#! /bin/bash

rm -rf libs/armeabi/* obj/local/armeabi/*
rm -rf libs/armeabi-v7a/* obj/local/armeabi-v7a/*
$ANDROID_HOME/android-ndk-r10e/ndk-build V=1 APP_STL=gnustl_static APP_ABI="armeabi armeabi-v7a" -j2
