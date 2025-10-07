# KrkrZ_dev with Plugins

KrkrZ_dev 项目在 KrkrZ 项目基础上包括了一些常见的插件（通常位于与 krkrz 或 tvpwin32 同目录的 plugin/ 目录下）.

**本项目提供了 Actions 自动编译，可以作为 Windows 端编译的参考.**

（x86 架构目前能够正常编译并运行，x64 架构的编译存在依赖问题，待解决）

（KAGParserEx 插件的编译存在问题，目前先只编译 KAGParser 插件，可以在编译后通过改名为 KAGParserEx 暂时解决启用时的检测）

## 准备

安装 Visual Studio 2022，进入 `Developer Command Prompt for VS 2022`，在该环境下，可以使用 VS 提供的 cmake、ninja、vcpkg包管理器等（以下基于 Win11 环境）.

请注意安装 NASM 2.10.09，将其配置到 PATH 中，使用 `nasm -v` 验证安装（KrkrZ 包含汇编语言，例如对 TLG6 格式的处理，参见 `\src\core\common\visual\IA32`）.

```
git clone
cd krkrz_dev
git submodule update --init --recursive --remote
```

## 编译

x86 架构：
```
set PRESET=x86-windows
make prebuild #vcpkg会自动下载依赖包
make
make install
```

x64 架构：
```
set PRESET=x64-windows
make prebuild
make
make install

```
