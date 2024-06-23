TARGET=$TARGET
GCCPTAH=$GCCPATH

if [ -z "$TARGET" ]; then
        echo "未设置目标架构的 TARGET 值 "
        exit 1
fi
if [ -z "$GCCPTAH" ]; then
        echo "设置musl-gcc下载目录为/opt/musl_gcc"
        GCCPTAH=/opt/musl_gcc
fi
mkdir -p /opt/musl_gcc
wget -q -c https://musl.cc/${TARGET}-cross.tgz -P /opt/musl_gcc/
tar zxf /opt/musl_gcc/${TARGET}-cross.tgz -C /opt/musl_gcc/

echo "PATH=/opt/musl_gcc/${TARGET}-cross/bin:\$PATH" >> $GITHUB_ENV
CC=/opt/musl_gcc/${TARGET}-cross/bin/${TARGET}-gcc
CXX=/opt/musl_gcc/${TARGET}-cross/bin/${TARGET}-g++
AR=/opt/musl_gcc/${TARGET}-cross/bin/${TARGET}-ar
LD=/opt/musl_gcc/${TARGET}-cross/bin/${TARGET}-ld
RANLIB=/opt/musl_gcc/${TARGET}-cross/bin/${TARGET}-ranlib
STRIP=/opt/musl_gcc/${TARGET}-cross/bin/${TARGET}-strip
echo "CC=$CC" >> $GITHUB_ENV
echo "CXX=$CXX" >> $GITHUB_ENV
echo "AR=$AR" >> $GITHUB_ENV
echo "LD=$LD" >> $GITHUB_ENV
echo "RANLIB=$RANLIB" >> $GITHUB_ENV
echo "STRIP=$STRIP" >> $GITHUB_ENV
