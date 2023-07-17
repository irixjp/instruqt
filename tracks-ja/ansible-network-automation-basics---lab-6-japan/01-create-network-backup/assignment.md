---
slug: create-network-backup
id: j0n0kzrwcjyr
type: challenge
title: ネットワーク設定のバックアップ
teaser: この演習ではネットワークコンフィグのバックアップを行う
notes:
- type: text
  contents: |-
    # さあはじめよう

    これで演習でのブリーフィングは終わりです

    ラボのセットアップが完了したら、このウィンドウの右下にある緑のスタートボタン <img src="https://github.com/IPvSean/pictures_for_github/blob/master/start_button.png?raw=true" width="100px" align="left"> をクリックします。
tabs:
- title: Automation controller WebUI
  type: service
  hostname: controller
  port: 443
- title: Automation controller Terminal
  type: terminal
  hostname: controller
- title: Visual Studio Code
  type: service
  hostname: controller
  path: /editor/
  port: 443
difficulty: basic
timelimit: 600
---
この演習では、Automation controller上で自動化ジョブを実行します。

🔐 ログイン情報
===
Automation controller にログインするには、画面上部の `Automation controller WebUI` タブを選択します。

認証情報は以下になります:

>**Controller username**:
> ```yaml
>admin
>```
>**Controller password**:
>```yaml
>ansible123!
>```


ステップ 1 - ネットワーク設定をバックアップするジョブテンプレートの実行
===

- 左のナビゲーションメニューの Resources の下にある **Templates** をクリックして、**Job Templates**に移動します。 <img src="https://github.com/IPvSean/pictures_for_github/blob/master/job_templates.png?raw=true">
- **Backup network configurations** を実行するには、ジョブの起動ボタンであるロケットボタンをクリックします:

<img src="https://github.com/IPvSean/pictures_for_github/blob/master/launch_job.png?raw=true">

ステップ2 - オプション - バックアップの確認
===

Visual Studio Codeタブでバックアップ構成を開きます。 Visual Studio Codeで`/backup`ディレクトリを開き、最新のタイムスタンプに移動します。 ジョブを複数回実行した場合は、複数のオプションがあります。 `cisco.txt`ファイルを開いて、Cisco IOS-XEの実行コンフィグレーションを表示します。

ステップ3 - 確認
===

下の緑色の`Check`ボタンをクリックして、実行されたジョブを確認します。


