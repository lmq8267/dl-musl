# 自动下载musl交叉编译工具链

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Flmq8267%2Fdl-musl&count_bg=%2395C10D&title_bg=%23555555&icon=github.svg&icon_color=%238DC409&title=%E8%AE%BF%E9%97%AE%E6%95%B0&edge_flat=false)](https://hits.seeyoufarm.com)

### 使用方法如下

#### 例如 aarch64平台 
```bash
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
    - name: 下载gcc
      uses: lmq8267/dl-musl@main
      with:
        target: aarch64-linux-musl

    - name: 输出gcc版本信息
      run: $CC -v
```

#### 也可以指定下载的目录  默认为/opt/musl_gcc/
```bash
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
    - name: 下载gcc
      uses: lmq8267/dl-musl@main
      with:
        target: mipsel-linux-musl  #下载的架构
        gccpath: /tmp/musl_gcc/  #设置下载的目录
        static: true  #添加-static静态链接标志
    - name: 输出gcc版本信息
      run: $CC -v
```

#### target可选架构
```bash
aarch64-linux-musl
aarch64_be-linux-musl
arm-linux-musleabi
arm-linux-musleabihf
armeb-linux-musleabi
armeb-linux-musleabihf
armel-linux-musleabi
armel-linux-musleabihf
armv5l-linux-musleabi
armv5l-linux-musleabihf
armv6-linux-musleabi
armv6-linux-musleabihf
armv7l-linux-musleabihf
armv7m-linux-musleabi
armv7r-linux-musleabihf
i486-linux-musl
i686-linux-musl
i686-w64-mingw32
m68k-linux-musl
microblaze-linux-musl
microblazeel-linux-musl
mips-linux-musl
mips-linux-musln32sf
mips-linux-muslsf
mips64-linux-musl
mips64-linux-musln32
mips64-linux-musln32sf
mips64el-linux-musl
mips64el-linux-musln32
mips64el-linux-musln32sf
mipsel-linux-musl
mipsel-linux-musln32
mipsel-linux-musln32sf
mipsel-linux-muslsf
or1k-linux-musl
powerpc-linux-musl
powerpc-linux-muslsf
powerpc64-linux-musl
powerpc64le-linux-musl
powerpcle-linux-musl
powerpcle-linux-muslsf
riscv32-linux-musl
riscv64-linux-musl
s390x-linux-musl
sh2-linux-musl
sh2-linux-muslfdpic
sh2eb-linux-musl
sh2eb-linux-muslfdpic
sh4-linux-musl
sh4eb-linux-musl
x86_64-linux-musl
x86_64-linux-muslx32
x86_64-w64-mingw32
```
