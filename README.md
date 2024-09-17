# 吉里吉里Z 統合リポジトリ 開発用

本体のソースコード、プラグインのソースコード、各種TJS2スクリプト、ドキュメント等開発関係のもの全てが入ったリポジトリ。
各種ファイルはサブモジュールで参照されている。

CMake 構築用作業中

## 作業手順

1. git clone
2. git submodule update --init --recursive

これでサブモジュール部分が展開されるので、全体の構成で作業できます。

## ビルド手順

```
make prebuild
make

# install 用定義が不十分
make install 
```