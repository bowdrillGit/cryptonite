#!/bin/bash

PROJECT_HOME=`pwd`
ANDROID_HOME=`pwd`/../.
ANDROID_SDK=~/.Android

LOG=$PROJECT_HOME/logbuild.log

cd $PROJECT_HOME

#
if [[ $1 == 'clean' ]]; then
    echo 'Cleaning'
    rm -rf ${ANDROID_HOME}/android-ndk-r10e
    rm -rf ${ANDROID_HOME}/android-toolchain
    rm -rf {$ANDROID_HOME}tools
    rm -rf ${PROJECT_HOME}/openssl/openssl-1.0.2f
    rm -rf ${PROJECT_HOME}/boost_1_60_0
    rm -rf ${PROJECT_HOME}/wx/wxWidgets-2.8.12
    rm -rf ${PROJECT_HOME}/dropbox-android-sdk-1.6.3
    rm -rf ${PROJECT_HOME}/ActionBarSherlock
    exit 0
fi
#
cd ${ANDROID_HOME}
echo 'Getting Android ndk r10'
wget -c  -c https://dl.google.com/android/repository/android-ndk-r10e-linux-x86_64.zip
echo 'Unzipping'

if [ ! -d android-ndk-r10e ]
then
    uz android-ndk-r10e-linux-x86_64.zip >/dev/null
fi

echo 'Building android toolchain'
cd ${ANDROID_HOME}/android-ndk-r10e/build/tools/
 ./make-standalone-toolchain.sh --arch=arm --ndk-dir=${ANDROID_HOME}/android-ndk-r10e --install-dir=${ANDROID_HOME}/android-toolchain --platform=android-21 --system=linux-x86_64

cd $PROJECT_HOME
chmod +x bin/agcc-vfp
ln -s /usr/bin/perl5.22-x86_4-linux-gnu ${PROJECT_HOME}/bin/perl5
PATH=$PATH:$PROJECT_HOME/bin
#
echo 'Building openssl'
cd ${PROJECT_HOME}/openssl
./download.sh
./build.sh

echo 'Building Fuse'
cd $PROJECT_HOME
git submodule init
git submodule update --remote
cd fuse293
./build.sh

echo 'Building RLOG'
cd ${PROJECT_HOME}/rlog
./download.sh
./build.sh
#
echo 'Building boost'
cd ${PROJECT_HOME}/boost
./download.sh
./build.sh
#
#
echo 'Building ENCFS1.8'
cd ${PROJECT_HOME}/encfs-1.8.1
sed -i 's/{HOME}/{ANDROID_HOME}/' encfs/config-arm-encfs.sh
./build.sh


ln -s ${PROJECT_HOME}/cryptonite/jni/android_fake.h ${PROJECT_HOME}/cryptonite/jni/android_key.h
#
cd ${PROJECT_HOME}/cryptonite
./jni-build.sh
#

cd ${PROJECT_HOME}
wget -c https://api.github.com/repos/JakeWharton/ActionBarSherlock/tarball/4.3.1
if [ ! -d ActionBarSherlock ]
then
    tar -xvf 4.3.1
    mv JakeWharton-ActionBarSherlock-071a61c ActionBarSherlock/
fi




cd ${PROJECT_HOME}/wx
./download.sh
./build.sh

echo 'fake dropbox keys'
cd ${PROJECT_HOME}/cryptonite
echo "db-xxxxxxxxxxxxxxx" > androidmanifest.xml.key
echo "db-xxxxxxxxxxxxxxx" > androidmanifest.xml.key2
cd ..
./insert_key.sh

echo 'Getting dropbox'
wget -c https://www.dropbox.com/developers/downloads/sdks/core/android/dropbox-android-sdk-1.6.3.zip
if [ ! -d dropbox-android-sdk-1.6.3. ]
then
    uz dropbox-android-sdk-1.6.3.zip >/dev/null
fi

cp ${PROJECT_HOME}/dropbox-android-sdk-1.6.3/lib/dropbox-android-sdk-1.6.3.jar $PROJECT_HOME/cryptonite/libs/
cp ${PROJECT_HOME}/dropbox-android-sdk-1.6.3/lib/json_simple-1.1.jar $PROJECT_HOME/cryptonite/libs/
cp ${PROJECT_HOME}/dropbox-android-sdk-1.6.3/lib/test/httpmime-4.0.3.jar $PROJECT_HOME/cryptonite/libs/

echo 'Updating packages'
# $ANDROID_SDK/Sdk/tools/bin/sdkmanager --update --verbose


echo 'Get deprecated android tools'
cd $ANDROID_HOME
wget -c https://dl.google.com/android/repository/tools_r25.2.3-linux.zip
if [ ! -d tools ]
then
    uz tools_r25.2.3-linux.zip >/dev/null
fi

cd $PROJECT_HOME/ActionBarSherlock/actionbarsherlock
$ANDROID_HOME/tools/android update project --target android-21 --path .


cd $PROJECT_HOME/cryptonite
echo 'Launching GUI to install SDK level 21 along with platform tools and build tools'
$ANDROID_HOME/tools/android sdk
$ANDROID_HOME/tools/android update project --target android-21 --path . -s



