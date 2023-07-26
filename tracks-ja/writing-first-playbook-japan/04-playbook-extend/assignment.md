---
slug: playbook-extend
id: rrdyehjjs4ka
type: challenge
title: Playbook の拡張
teaser: 自動化は単なる 1 つのタスクではありません。さらに追加しましょう。
notes:
- type: text
  contents: デフォルトでは、Ansible はホストのパターンに一致するすべてのマシンに対して、 各タスクを 1 つずつ順番に実行します。各タスクは、特定の引数を指定してモジュールを実行します。
    タスクがすべてのターゲットマシンで実行されると、Ansible は次のタスクに移動します。
- type: text
  contents: Playbook を実行すると、Ansible は、 接続、すべてのプレイとタスクの名前行、各タスクが各マシンで成功したか失敗したか、 各タスクが各マシンで変更を加えたかどうかに関する情報を返します。
    Ansible は Playbook の実行の最後に、対象となったノードとそのパフォーマンスの概要を提供します。 一般的な失敗と致命的な到達不能な通信試行は、カウントで分けて保持されます。
tabs:
- title: editor
  type: service
  hostname: control
  path: /editor/
  port: 443
- title: control
  type: terminal
  hostname: control
difficulty: basic
timelimit: 1
---
👋 はじめに
===
#### 推定所要時間: *3 分*<p>
この課題では、`apache.yml` Ansible Playbook を拡張して、追加の実行タスクを含めます。

☑️ タスク 1 - apache.yml Playbook への別タスクの追加
===

*editor* タブ内で、ファイル `apache.yml` を開きます。ファイルの最後に次のタスクを追加します。

>### **❗️注意❗️**
>タスクが前のタスクと同じようにインデントされていることを確認してください!


```
  - name: Apache enabled and running
    ansible.builtin.service:
      name: httpd
      enabled: true
      state: started
```

☑️ タスク 2 - apache.yml Playbook の実行
===

*control* タブに切り替えて、対応するディレクトリー `ansible-files` 内で Playbook を起動します。

```
cd ansible-files
```

```
ansible-navigator run apache.yml
```

出力で何か気づきましたか?

最初のタスクは OK を報告するだけですが、2 番目のタスクはステータスが変化したことを報告しています。

理由

これは冪等性の作用です。最初のタスクはすでに完了していますが、新しく追加されたタスクは完了していません。


☑️ タスク 3 - Apache のステータスの確認
===

Ansible Playbook が正常に完了したら、次のアドホックコマンドを実行して、サービスが実際に実行されていることを確認します。

```
ansible node1 -m ansible.builtin.service_facts | grep httpd.service -A 4
```
✅ 次の課題
===
以下の `Check` ボタンを押して、タスクが完了したら次のチャレンジに移動します。

🐛 問題が発生していますか ?
====

問題が発生した場合や、正しくない点に気付いた場合は、[open an issue](https://github.com/ansible/instruqt/issues/new?labels=writing-first-playbook&title=Issue+with+Writing+First+Playbook+slug+ID:+playbook-extend&assignees=rlopez133)をクリックしてください。

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
