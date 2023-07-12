# track

## 使用法
instruqt cli を使用して、webui から作成された track をプルし、このディレクトリーにコミットします。

track テンプレートが作成され、フィールドにどのような意味があるのかを確認できます。`instruqt track create --from redhat/template-slug-url-of-track --title New track slug --slug new slug` のような Instruqt CLI を使用して、この track のコピーを作成できます。

track をコピーしたら、`cd` で track ディレクトリーに移動して、`instruqt track push`  を実行し、Instruqt 組織にプッシュしてさらに編集をします。

### 便利な参考資料
- [最初の track のビルド](https://docs.instruqt.com/building-tracks/your-first-track)
- [track ログの表示](https://docs.instruqt.com/building-tracks/viewing-logs)
- [track のテスト](https://docs.instruqt.com/publishing-tracks/automated-testing)

## 備考

以下は、一時停止の時間を延長して、仮想マシンの準備を整えてから、Start Challenge ボタンを有効にする場合に便利です。
```
#!/bin/bash
until [ -f /opt/instruqt/bootstrap/host-bootstrap-completed ]
do
    sleep 1
done
```
### 名前解決
track の "Environment" セクション (または `config.yml`) で各ノードに指定した名前は、お使いの環境の各ノードに伝播されます。`ping node{1..2}` が機能するはずです。

### SSH 鍵
Instruqt は、全ノードにおける root ユーザーの ssh 鍵管理を処理するため、`node1-$ ssh node2` のみが機能するようにします。現在、Windows ホストのシェルはありませんが、このリポジトリーから設定された Windows イメージは ssh をインストールします。仮想マシンの環境で定義された短縮名は、ssh 接続で使用されるホスト名です。 

