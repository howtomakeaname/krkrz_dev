# 吉里吉里Z 統合リポジトリ 開発用

本体のソースコード、プラグインのソースコード、各種TJS2スクリプト、ドキュメント等開発関係のもの全てが入ったリポジトリ。
各種ファイルはサブモジュールで参照されている。

CMake 構築用作業中

## 作業手順

1. git clone
2. git submodule update --init --recursive

これでサブモジュール部分が展開されるので、全体の構成で作業できます。

## ビルド手順

cmake による構築になります。
環境別定義は、CMakePresets.json に定義されているので、
それを利用してビルドできます。

- Ninja の MultiConfig での定義での構築定義になっています
- preset 毎にビルドフォルダが別れるようになってます


ビルド作業用の Makefile が準備されています


    環境変数
    PRESET          cmakeのプリセット名を指定
    BUILD_TYPE      ビルド対象の config 指定 Debug/RelWithDebInfo/Release

    ビルドルール
    prebuild        cmake の構築呼び出し
    build           cmake のビルド呼び出し
    install         cmake のインストール呼び出し


win32版

```
make prebuild
make
```

win64版

```
export PRESET=x64-windows
make prebuild
make
```