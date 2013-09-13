Feature: 警報を新規に作成する

  手順書検索システムの管理者として
  警報を新規に作成したい
  それによって、警報をシステムからアクセスできるようになる

  @wip
  Scenario: 新規警報を既存の警報パネルに割り当てる
    Given 警報の新規作成画面が表示されている
    When 警報名称を入力する
    And 既存の警報パネルの番号を入力する
    And 警報パネルの、警報が割り当てられていない窓のロケーションを入力する
    And 警報の手順書をアップロードする
    And 警報の新規作成ボタンをクリックする
    Then 警報の詳細ページが表示される
    And 正常に警報が作成されたメッセージが表示されている
    And 詳細ページでは、警報を割り当てた警報パネルへのリンクがある
    And 詳細ページでは、警報の手順書へのリンクがある

#  Scenario: 新規警報を存在しない警報パネルに割り当てる

#  Scenario: 新規警報のための手順書をアップロードする
