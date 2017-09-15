#!/bin/bash

PROJECT_HOME=`pwd`
ANDROID_HOME=`pwd`/../.
ANDROID_SDK_TOOLS=/home/nate/.Android/Sdk/tools/bin
. env.sh

LOG=$PROJECT_HOME/logbuild.log

cd $PROJECT_HOME

#
# echo 'Cleaning'
# rm $LOG
# rm -rf ${ANDROID_HOME}/android-ndk-r10e
# rm -rf ${ANDROID_HOME}/android-toolchain
# rm -rf ${PROJECT_HOME}/openssl/openssl-1.0.2f
# rm -rf ${PROJECT_HOME]/boost_1_60_0
# rm -rf ${PROJECT_HOME}/wx/wxWidgets-2.8.12/
#
# cd ${ANDROID_HOME}
# echo 'Getting Android ndk r10'
# wget -c  -c https://dl.google.com/android/repository/android-ndk-r10e-linux-x86_64.zip
# echo 'Unzipping'
# uz android-ndk-r10e-linux-x86_64.zip>
# echo 'Building android toolchain'
# cd ${ANDROID_HOME}/android-ndk-r10e/build/tools/
#  ./make-standalone-toolchain.sh --arch=arm --ndk-dir=${ANDROID_HOME}/android-ndk-r10e --install-dir=${ANDROID_HOME}/android-toolchain --platform=android-21 --system=linux-x86_64

# cd $PROJECT_HOME
# chmod +x bin/agcc-vfp
# ln -s /usr/bin/perl5.22-x86_4-linux-gnu ${PROJECT_HOME}/bin/perl5
PATH=$PATH:$PROJECT_HOME/bin
#
# echo 'Building openssl'
# cd ${PROJECT_HOME}/cryptonite/openssl
# ./download.sh
# ./build.sh

# echo 'Building Fuse'
# cd $PROJECT_HOME/cryptonite
# git submodule init
# git submodule update --remote
# cd fuse293
# ./build.sh

# echo 'Building RLOG'
# cd ${PROJECT_HOME}/cryptonite/rlog
# ./download.sh
# ./build.sh
#
# echo 'Building boost'
# cd ${PROJECT_HOME}/boost
# ./download.sh
# ./build.sh
#
#
# echo 'Building ENCFS1.8'
# cd ${PROJECT_HOME}/cryptonite/encfs-1.8.1
# sed -i 's/{HOME}/{ANDROID_HOME}/' encfs/config-arm-encfs.sh
# ./build.sh


# ln -s ${PROJECT_HOME}/cryptonite/jni/android_fake.h ${PROJECT_HOME}/cryptonite/jni/android_key.h
#
# cd ${PROJECT_HOME}/cryptonite
# ./jni-build.sh
#

# cd ${PROJECT_HOME}
# wget -c https://api.github.com/repos/JakeWharton/ActionBarSherlock/tarball/4.4.0
# tar -xvf 4.4.0
# mv JakeWharton-ActionBarSherlock-5a15d92/ ActionBarSherlock/


#
# cd ${PROJECT_HOME}/wx
# ./download.sh
# ./build.sh
#
# echo 'Fake dropbox keys'
# cd ${PROJECT_HOME}/cryptonite
# echo "db-xxxxxxxxxxxxxxx" > AndroidManifest.xml.key
# echo "db-xxxxxxxxxxxxxxx" > AndroidManifest.xml.key2
# ./insert_key.sh
#

echo 'Updating packages'
$ANDROID_SDK_TOOLS/sdkmanager --update --verbose


