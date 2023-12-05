---
slug: appdeploy
id: jfmj0xtl6juw
type: challenge
title: Ansible Automation Platformを使って、アプリケーションをデプロイする
teaser: Ansible Automation Platformを使って、アプリケーションをデプロイします。
notes:
- type: text
  contents: |
    # 課題の概要

    この課題では、Linuxホストにアプリケーションをデプロイします。この課題用に、既にジョブテンプレートが作成されています。ジョブテンプレートの名前は、`Deploy Application`です。

    次にジョブテンプレートを起動し、その進捗状況を監視します。

    また、Ansible Automation Platformのアドホック機能を使用して、アプリケーションがインストールされていることを確認します。これは組み込みの機能であり、運用チームがAnsible Playbookを作成しなくても、すぐに価値を得ることができます。
- type: text
  contents: |-
    # インフラストラクチャーのユースケース

    Ansibleは、多くのハイブリッドクラウドタスクを自動化できるだけでなく、Linux および Windowsインフラストアクチャーのユースケースも自動化できます。Red Hatでは、Linux および Windowsホストの自動化を`infrastructure automation`と呼んでいます。

    ![use-caes-infra.png](../assets/use-caes-infra.png)

    ただし、今私達がここで扱っているユースケースは、アプリケーションのデプロイメントです。
- type: text
  contents: |-
    # では始めましょう

    課題の説明はこれで終了です！

    ラボ環境のセットアップが完了したら、このウインドウの右下隅にある緑色のStartボタン <img src="https://github.com/IPvSean/pictures_for_github/blob/master/start_button.png?raw=true" width="100px" align="left"> をクリックしてください。
tabs:
- title: Automation Controller
  type: service
  hostname: controller
  port: 443
- title: AWS console
  type: service
  hostname: cloud-client
  path: /
  port: 80
- title: Automation Controller Terminal
  type: terminal
  hostname: controller
difficulty: basic
timelimit: 900
---
👋 課題の概要
===
## あなたの課題
### 想定時間: *15分*<p>

> Ansible Automation Platformを使ったアプリケーションのデプロイ

☑️ タスク1 - Linuxホストにアプリケーションをデプロイするジョブテンプレートの実行
===

`Ansible Automation Controller`にログインします。
- ラボ上部の`Automation Controller`タブをクリックします。

次の資格情報でログインします: <br>
*Login credentials:*<p>
`User:  admin` <p>
`Password:  ansible123!` <p>

---

`Deploy Application`ジョブテンプレートを選択して、`Launch`をクリックして起動するか、`Rocket Launcher` 🚀アイコンをクリックして、ジョブテンプレートを起動します。

デプロイするアプリケーションと、デプロイ先のLinuxホストを選択するように求められます。

1. `Survey`ビュー
   * デフォルトのアプリケーションは`httpd`です。インストールするアプリケーションのリストに`nginx`を追加してください。
   * ホストについては、デフォルトの`rhel1`に`rhel2`を追加して、両方のホストにインストールできようにします。`Next`をクリックします。
2. `Preview`ビュー
   * 表示される詳細と変数を確認し、`Launch`をクリックします。

ジョブの進捗状況を監視します。*完了まで少し時間がかかります。* 出力には、インストールされたホストとアプリケーションがリストされます。

☑️ タスク2 - アドホックコマンドの実行とnginxのインストールの確認
===

このタスクでは、`rhel1`と`rhel2`でアドホックコマンドを実行して、先程実行したアプリケーションデプロイメントのジョブから`nginx`がインストールされたことを確認します。

左側のナビゲーションメニューから`Resources`、`Inventories`へ移動し、`AWS Inventory`を選択します。さらに`Hosts`メニューをクリックして、`rhel1`と`rhel2`の横のチェックボックスをクリックします。

`rhel1`と`rhel2`を選択したら、`Run Command`ボタンをクリックします。
1. `Details`ビューで、`Module`ドロップダウンから`service`を選択し、`Arguments`フィールドに`name=nginx`と入力し、`Next`をクリックします。
2. `Execution Environment`ビューで`AWS Execution Environment`を選択し、`Next`をクリックします。
3. `Credential`ビューで`RHEL on AWS - SSH KEY`を選択し、`Next`をクリックします。
4. `Preview`ビューで`Launch`をクリックします。

これには少し時間がかかります。出力にはホストがリストされ、`nginx`の詳細が表示されます。

この課題では、自動化を使用してアプリケーションをデプロイする方法について説明しました。また、ターゲットホストでアドホックコマンドを実行する方法についても説明しました。Ansible Automation Platformを使用してできることは、さらに沢山あります。

---
**Red Hat Ansible Automation Platformを使用した、(AWSでの)クラウドオペレーションタスクの自動化について学習するために、時間を割いていただきありがとうございました。同様のことは、他のクラウド環境でも簡単に実行できます。**

🐛 問題が発生しましたか?
====

問題が発生した場合、もしくはなにか正しくないことに気づいた場合は、こちらから[イシューをオープン](https://github.com/ansible/instruqt/issues/new?title=Issue+with+Ansible+Hybrid+Cloud+Automation+-+Infrastructure+visibility&assignees=ipvsean)してください。

<style type="text/css" rel="stylesheet">
  .lightbox {
    display: none;
    position: fixed;
    justify-content: center;
    align-items: center;
    z-index: 999;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    padding: 1rem;
    background: rgba(0, 0, 0, 0.8);
    margin-left: auto;
    margin-right: auto;
    margin-top: auto;
    margin-bottom: auto;
  }
  .lightbox:target {
    display: flex;
  }
  .lightbox img {
    /* max-height: 100% */
    max-width: 60%;
    max-height: 60%;
  }
  img {
    display: block;
    margin-left: auto;
    margin-right: auto;
    width: 100%;
  }
  h1 {
    font-size: 18px;
  }
    h2 {
    font-size: 16px;
    font-weight: 600
  }
    h3 {
    font-size: 14px;
    font-weight: 600
  }
  p span {
    font-size: 14px;
  }
  ul li span {
    font-size: 14px
  }
</style>
