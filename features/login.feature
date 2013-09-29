Feature: ユーザーはログインする

  ユーザーとして
  システムに自分であることを認識させたい
  それによってシステムの自分用の設定や、検索の履歴などを利用することができる

  Scenario: ログインしていない状態で検索をする
    Given そのパソコンにはユーザーの記録が残っていない
    When 検索フィールドにキーワードを入力する
    Then ログインの画面にリダイレクトされる

  @wip
  Scenario: 検索の前にログインを求められ、その後に検索が実行される
    Given 警報の一覧のページが表示されている
    And 自分は "foo" という名前であらかじめユーザー登録してある
    When 検索フィールドにキーワードを入力する
    And ログイン画面が表示されるので、そこで自分の名前 "foo" を選択する
    Then 「ようこそ、foo さん」と画面に表示される
    And 検索結果が画面に表示される
