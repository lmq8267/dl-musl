# 自动下载musl交叉编译工具链

### 使用方法如下

### 例如 aarch64平台 
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

### 也可以指定下载的目录  默认为/opt/musl_gcc/
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
        target: mipsel-linux-musl
        gccpath: /tmp/musl_gcc/
    - name: 输出gcc版本信息
      run: $CC -v
```
