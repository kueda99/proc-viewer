Feature: 警報の手順書の管理

  手順書が改訂されたら、簡単にアップデートして常に最新の手順書を参照できるように
  手順書検索システムの管理者として
  手順書の属性変更や手順書のアップロードを管理できるようにしたい

  @wip
  Scenario: 警報の手順書をアップロードする画面を表示する
    Given ある警報がある
    When その警報の編集画面を表示させる
    And 手順書の新規作成のリンクをクリックする
    Then 手順書の新規作成の画面が表示される
    And 手順書を割り当てる警報が判別できるように、画面に警報の名称が表示される
    And 改定番号を入力するフィールドがある
    And 改訂日を入力するフィールドがある
    And 手順書の過去のリビジョンを選択できるセレクトボックスが表示されている
    And リビジョンのセレクトボックスのデフォルト値は、その警報の最新の手順書のリビジョンである

  Scenario: 手順書の新規作成の画面で警報の手順書を作成する
    Given ある警報がある
    When その警報の手順書の新規作成の画面を表示させる
    And 手順書の改定番号に 6 を入力する
    And 手順書の改訂日に 2013/9/24 を入力する
    And 手順書のファイルをアップロードする
    Then 手順書の詳細画面が表示される
    And 警報の編集画面に戻るためのリンクがある
    And 改定番号が表示されている
    And 改訂日が表示されている
    And 手順書を表示するリンクがある
