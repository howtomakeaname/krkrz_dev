# 吉里吉里Z 統合リポジトリ 開発用
本体のソースコード、プラグインのソースコード、各種TJS2スクリプト、ドキュメント等開発関係のもの全てが入ったリポジトリ。
各種ファイルはサブモジュールで参照されている。

ワムソフトカスタム版作業用レポジトリになります

全体としては wtnbgo/krkrz_dev の fork です

src/core の参照先→ wamsoft/krkrz

- 一般公開されてるプラグインは wtnbgo/krkrz_dev 側で submodule 参照を追加して、こちらのレポジトリにも反映かけます
- ワムソフト独自プラグインは、wamsoft 配下に private なレポジトリを作成して、このレポジトリの src/plugins/win32 
  以下に submodule で参照を追加します


## 作業手順

1. git clone
2. git submodule init
3. git submodule update

これでサブモジュール部分が展開されるので、全体の構成で作業できます。
