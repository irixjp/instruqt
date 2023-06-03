---
slug: controller-getting-started-jt
id: hs4rofyvh9pc
type: challenge
title: Using job templates
teaser: In this challenge, we'll run automation using a Job Template
notes:
- type: text
  contents: "# ジョブテンプレートを使用した自動化の実行\n<br>\n<p align=\"center\">\n
    \ <img width=\"700px\" src=\"https://raw.githubusercontent.com/craig-br/instruqt-tracks/devel/assets/controller/controller_jt.png\">\n</p>\n<br>\n\n[**ジョブ
    テンプレート **](https://docs.ansible.com/automation-controller/latest/html/userguide/job_templates.html)
    は、Ansible Playbook を実行するための定義およびパラメーターのセットです。\\n\\n
    コントローラーでは、ジョブテンプレートとは `ansible-playbook`
    コマンドと、コマンドラインから実行するときに使用できるすべてのフラグを視覚的に表したものです。\n\n
    <style type=\"text/css\" rel=\"stylesheet\">\nh1 {\n\ttext-align: center\n}\n</style>"
tabs:
- title: コントローラーダッシュボード
  type: service
  hostname: controller
  port: 443
- title: Controller CLI
  type: terminal
  hostname: controller
- title: Host01 CLI
  type: terminal
  hostname: host01
- title: Host02 CLI
  type: terminal
  hostname: host02
- title: エディター
  type: service
  hostname: controller
  path: /editor/
  port: 443
difficulty: basic
timelimit: 600
---
## 課題

*ログイン認証情報:*
ユーザー: **admin**
パスワード: **ansible123!**

すべてのタスクはコントローラーダッシュボードで実行されます

* **Templates** は、ナビゲーションバーから開きます。
![jtmenu](https://raw.githubusercontent.com/craig-br/instruqt-tracks/devel/assets/controller/controller-inst-templates-menu.png)
***
<br>

* `Debug-Info` ジョブテンプレートをクリックします。
![jtclick](https://raw.githubusercontent.com/craig-br/instruqt-tracks/devel/assets/controller/controller-inst-jt-click.png)
***
<br>

* `Edit` をクリック
![jtedit](https://raw.githubusercontent.com/craig-br/instruqt-tracks/devel/assets/controller/controller-inst-jt-edit.png)
***
<br>

* いくつかのオプションを詳しく見てみましょう:
  * 以前に作成した `Lab-Inventory` を使用していることに注意してください
  * `playbooks/infrastructure/debug_info.yml` を実行します
  * SSH クレデンシャルを使用して、**host01** と **host02** を、`Lab-Inventory` で認証にしています。
![jtexplore](https://raw.githubusercontent.com/craig-br/instruqt-tracks/devel/assets/controller/controller-inst-jt-explore.png)
***
<br>

* **Cancel** をクリックしてから、**Launch** を押して起動します。
![inv_src](https://raw.githubusercontent.com/craig-br/instruqt-tracks/devel/assets/controller/controller-inst-jt-launch.png)
***
<br>

* この **ジョブテンプレート** は、`host01` と `host02` を持つ `Web` グループからデバッグ情報を収集します
  * 出力を見て、フィルターを調べます。
![inv_src](https://raw.githubusercontent.com/craig-br/instruqt-tracks/devel/assets/controller/controller-inst-jt-output.png)
***
<br>

**確認が終わりましたら、下のチェックボタンを押してください。お疲れさまでしたトラックを完了しました。**

<style type="text/css" rel="stylesheet">
h1 {
	text-align: center
	}
	img {
		width: 100%
	}
</style>
