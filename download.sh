TARGET=$TARGET
GCCPTAH=$GCCPATH
STATIC=$STATIC

if [ -z "$TARGET" ]; then
        echo "【错误】未设置目标架构的 TARGET 值 "
        exit 1
fi
if [ -z "$GCCPTAH" ]; then
        echo "设置musl-gcc下载目录为/opt/musl_gcc/"
        GCCPTAH=/opt/musl_gcc/
else
       if [[ ! $GCCPTAH == /* ]]; then
           GCCPTAH="/$GCCPTAH"
       fi
       if [[ ! $GCCPTAH == */ ]]; then
          GCCPTAH="${GCCPTAH}/"
       fi
fi
if [ "$STATIC" = "true" ]; then
   STATIC=" -static"
else
   STATIC=
fi
case "$TARGET" in
    "aarch64-linux-musl" | "aarch64_be-linux-musl" | "arm-linux-musleabi" | "arm-linux-musleabihf" | "armeb-linux-musleabi" | "armeb-linux-musleabihf" | "armel-linux-musleabi" | "armel-linux-musleabihf" )
        ;;
    "armv5l-linux-musleabi" | "armv5l-linux-musleabihf" | "armv6-linux-musleabi" | "armv6-linux-musleabihf" | "armv7l-linux-musleabihf" | "armv7m-linux-musleabi" | "armv7r-linux-musleabihf" )
        ;;
    "i486-linux-musl" | "i686-linux-musl" | "i686-w64-mingw32" | "m68k-linux-musl" | "microblaze-linux-musl" | "microblazeel-linux-musl" | "mips-linux-musl" | "mips-linux-musln32sf" )
        ;;
    "mips-linux-muslsf" | "mips64-linux-musl" | "mips64-linux-musln32" | "mips64-linux-musln32sf" | "mips64el-linux-musl | "mips64el-linux-musln32" | "mips64el-linux-musln32sf" | "mipsel-linux-musl" )
        ;;
    "mipsel-linux-musln32" | "mipsel-linux-musln32sf" | "mipsel-linux-muslsf" | "or1k-linux-musl" | "powerpc-linux-musl" | "powerpc-linux-muslsf" | "powerpc64-linux-musl" | "powerpc64le-linux-musl" )
        ;;
    "powerpcle-linux-musl" | "powerpcle-linux-muslsf" | "riscv32-linux-musl" | "riscv64-linux-musl" | "s390x-linux-musl" | "sh2-linux-musl" | "sh2-linux-muslfdpic" | "sh2eb-linux-musl" )
        ;;
    "sh2eb-linux-muslfdpic" | "sh4-linux-musl" | "sh4eb-linux-musl" | "x86_64-linux-musl" | "x86_64-linux-muslx32 | "x86_64-w64-mingw32"  )
        ;;
    *)
        echo "【错误】TARGET: $TARGET 填写错误 ！"
        echo "请在以下支持的架构列表里选一个"
        echo "aarch64-linux-musl"
        echo "aarch64_be-linux-musl"
        echo "arm-linux-musleabi"
        echo "arm-linux-musleabihf"
        echo "armeb-linux-musleabi"
        echo "armeb-linux-musleabihf"
        echo "armel-linux-musleabi"
        echo "armel-linux-musleabihf"
        echo "armv5l-linux-musleabi"
        echo "armv5l-linux-musleabihf"
        echo "armv6-linux-musleabi"
        echo "armv6-linux-musleabihf"
        echo "armv7l-linux-musleabihf"
        echo "armv7m-linux-musleabi"
        echo "armv7r-linux-musleabihf"
        echo "i486-linux-musl"
        echo "i686-linux-musl"
        echo "i686-w64-mingw32"
        echo "m68k-linux-musl"
        echo "microblaze-linux-musl"
        echo "microblazeel-linux-musl"
        echo "mips-linux-musl"
        echo "mips-linux-musln32sf"
        echo "mips-linux-muslsf"
        echo "mips64-linux-musl"
        echo "mips64-linux-musln32"
        echo "mips64-linux-musln32sf"
        echo "mips64el-linux-musl"
        echo "mips64el-linux-musln32"
        echo "mips64el-linux-musln32sf"
        echo "mipsel-linux-musl"
        echo "mipsel-linux-musln32"
        echo "mipsel-linux-musln32sf"
        echo "mipsel-linux-muslsf"
        echo "or1k-linux-musl"
        echo "powerpc-linux-musl"
        echo "powerpc-linux-muslsf"
        echo "powerpc64-linux-musl"
        echo "powerpc64le-linux-musl"
        echo "powerpcle-linux-musl"
        echo "powerpcle-linux-muslsf"
        echo "riscv32-linux-musl"
        echo "riscv64-linux-musl"
        echo "s390x-linux-musl"
        echo "sh2-linux-musl"
        echo "sh2-linux-muslfdpic"
        echo "sh2eb-linux-musl"
        echo "sh2eb-linux-muslfdpic"
        echo "sh4-linux-musl"
        echo "sh4eb-linux-musl"
        echo "x86_64-linux-musl"
        echo "x86_64-linux-muslx32"
        echo "x86_64-w64-mingw32"
        exit 1
        ;;
esac
mkdir -p ${GCCPTAH}
echo "开始下载https://musl.cc/${TARGET}-cross.tgz"
wget -q -c https://musl.cc/${TARGET}-cross.tgz -P $GCCPTAH
echo "解压${GCCPTAH}${TARGET}-cross.tg到${GCCPTAH}"
tar zxf ${GCCPTAH}${TARGET}-cross.tgz -C $GCCPTAH

echo "PATH=${GCCPTAH}${TARGET}-cross/bin:\$PATH" >> $GITHUB_ENV
CC=${GCCPTAH}${TARGET}-cross/bin/${TARGET}-gcc
CXX=${GCCPTAH}${TARGET}-cross/bin/${TARGET}-g++
AR=${GCCPTAH}${TARGET}-cross/bin/${TARGET}-ar
LD=${GCCPTAH}${TARGET}-cross/bin/${TARGET}-ld
RANLIB=${GCCPTAH}${TARGET}-cross/bin/${TARGET}-ranlib
STRIP=${GCCPTAH}${TARGET}-cross/bin/${TARGET}-strip
GCC_VERSION=$(ls ${GCCPATH}${TARGET}-cross/${TARGET}/lib/gcc/${TARGET})
CFLAGS="-I ${GCCPTAH}${TARGET}-cross/${TARGET}/include -L ${GCCPTAH}${TARGET}-cross/${TARGET}/lib -I ${GCCPTAH}${TARGET}-cross/${TARGET}/lib/gcc/${TARGET}/${GCC_VERSION}/include -L ${GCCPTAH}${TARGET}-cross/${TARGET}/lib/gcc/${TARGET}/${GCC_VERSION} ${STATIC}$CFLAGS"
CXXFLAGS="$CFLAGS $CXXFLAGS"
LDFLAGS="$CFLAGS $LDFLAGS"
if ! $CC -v >/dev/null 2>&1; then
    echo "【错误】 交叉编译工具链${GCCPTAH}${TARGET}-cross/bin/${TARGET}-  下载失败！"
    exit 1
else
    echo "交叉编译工具链${GCCPTAH}${TARGET}-cross/bin/${TARGET}-  下载成功！"
fi
echo "CC=$CC" >> $GITHUB_ENV
echo "CXX=$CXX" >> $GITHUB_ENV
echo "AR=$AR" >> $GITHUB_ENV
echo "LD=$LD" >> $GITHUB_ENV
echo "RANLIB=$RANLIB" >> $GITHUB_ENV
echo "STRIP=$STRIP" >> $GITHUB_ENV
echo "CFLAGS=$CFLAGS" >> $GITHUB_ENV
echo "CXXFLAGS=$CXXFLAGS" >> $GITHUB_ENV
echo "LDFLAGS=$LDFLAGS" >> $GITHUB_ENV
