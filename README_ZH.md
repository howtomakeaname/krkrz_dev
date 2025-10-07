# KrkrZ_dev with Plugins

## 准备

安装 Visual Studio 2022，进入 `Developer Command Prompt for VS 2022`，在该环境下，可以使用 VS 提供的 cmake、ninja、vcpkg包管理器等.（以下基于 Win11 环境）

```
git clone
cd krkrz_dev
git submodule update --init --recursive --remote
```

## 编译

x86架构：
```
set PRESET=x86-windows
make prebuild #vcpkg会自动下载依赖包
make
make install
```

x64架构：
```
set PRESET=x64-windows
make prebuild
make
make install
```