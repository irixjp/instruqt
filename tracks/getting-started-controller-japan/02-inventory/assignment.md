---
slug: inventory
id: xsapt1ff11ac
type: challenge
title: Create an Inventory
teaser: Let's take inventory
notes:
- type: text
  contents: "# インベントリ\n<br>\n<p align=\"center\">\n  <img width=\"700px\" src=\"https://raw.githubusercontent.com/craig-br/instruqt-tracks/devel/assets/controller/controller-inventory.png\">\n</p>\n<br>\n\nAn
    [**Inventory**](https://docs.ansible.com/automation-controller/latest/html/userguide/inventories.html)
    は、ジョブを起動できるホストのコレクションです(Ansible インベントリーファイルと同様)。\n\n<style type=\"text/css\" rel=\"stylesheet\">\nh1
    {\n\ttext-align: center\n\t}\n</style>\n"
- type: text
  contents: "# インベントリ\n<br>\n<p align=\"center\">\n  <img width=\"700px\" src=\"https://raw.githubusercontent.com/craig-br/instruqt-tracks/devel/assets/controller/controller-hosts.png\">\n</p>\n<br>\n\n[**Inventories**](https://docs.ansible.com/automation-controller/latest/html/userguide/inventories.html#inventory-plugins)
    はグループに分割され、これらのグループには実際のホストが含まれます。グループは、 ホスト名をコントローラーに入力するか、サポート対象のクラウドプロバイダーから入力して、手動で読み込むことができます。\n\n<style
    type=\"text/css\" rel=\"stylesheet\">\nh1 {\n\ttext-align: center\n\t}\n</style>"
tabs:
- title: コントローラーダッシュボード
  type: service
  hostname: controller
  port: 443
- title: Controller CLI
  type: terminal
  hostname: controller
- title: Host 01 CLI
  type: terminal
  hostname: host01
- title: Host 02 CLI
  type: terminal
  hostname: host02
- title: Editor
  type: service
  hostname: controller
  path: /editor/
  port: 443
difficulty: basic
timelimit: 600
---
## コントローラーダッシュボードから以下を作成します:

*ログイン認証情報:*<p>
ユーザー: admin <p>
パスワード: ansible123!

> **注記:**<p>
>
> すべてのフィールドで **大文字と小文字** が区別されるため、チェックは失敗します。割り当てで使用されているものと同じ大文字を使用していることを確認してください。

自動化コントローラーインスタンスに加えて、サンドボックス環境には、`host01` と `host02` の 2 つの仮想マシンも含まれています。

また、これらのマシンには追加のターミナルタブが追加されているので、見て回ることができます。

これらのマシンは、ssh キーを使用して相互に `ssh` できるように設定されています。

## 課題

すべてのタスクは、自動化コントローラーのダッシュボードで実行されます
* **Resources** セクションの下のサイドナビゲーションで、**Inventories** をクリックします
* **Inventories** の下で、**Add** をクリックします
* **Add inventory** をクリックします。
* `Lab-Inventory` という名前で新しいインベントリーを作成し、他の項目はそのままにして **save** をクリックします。
![インベントリー](https://raw.githubusercontent.com/craig-br/instruqt-tracks/devel/assets/controller/controller-inventory.png)
***
<br>

`Lab-Inventory` を作成したら、**Hosts** をクリックします。

* "Add" をクリックします。
* **Name** テキストボックスに `host01` という名前を入力します。他はそのままで、 **save** をクリックします。
* 上記の手順を繰り返し `host02` を作成します。

![hosts](https://raw.githubusercontent.com/craig-br/instruqt-tracks/devel/assets/controller/controller-hosts.png)

***
<br>

* `host01` と `host02` を `Lab-Inventory` に追加したら、Inventory リストに戻ります。
* `Lab-Inventory` をクリックし、トップメニューで **Groups** を選択します。
* **Add** をクリックして新しいグループを作成します。
* `Lab-Inventory` に `web` という新しいグループを作成します、
* 作成したら **Save** をクリックします。
![group](https://raw.githubusercontent.com/craig-br/instruqt-tracks/devel/assets/controller/controller-inst-add-group.png)
***
<br>

* 新しく作成した `Web` グループをクリックし、トップメニューの **Hosts** をクリックします。
* **Add existing host** をクリックします。ポップアップが表示されます。
* `host01` と `host02` を `Web` グループへ追加します。
![group](https://raw.githubusercontent.com/craig-br/instruqt-tracks/devel/assets/controller/controller-inst-add-hosts-group.png)
***
<br>

**完了したら、下の Check ボタンを押して、次のチャレンジに移動します。**
