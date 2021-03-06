# Techbo
技術者向けのTech Blog
https://techbo.herokuapp.com/

# 技術
|技術要素|名前|備考|
|:---:|:---------:|:-------:|
|言語|Ruby||v2.3.3|
|F/W|Rails|v5.0.1|
|API|Jbuilder||
|テンプレートエンジン|Slim||
|altJS|CoffeeScript||
|CSS Framework|Semantic UI|v2.2|
|Pager|Kaminari||
|画像|Paperclip + S3||
|DB|Postgres||
|PaaS|Heroku||

# 実装したこと
- ログイン機能
- 画像投稿
  - プレビュー機能
- 記事投稿
  - タグを追加できる
  - マークダウン記法
  - 変更差分を確認
  - ドラフト機能
- 記事にコメント機能
- シェア機能(Tw, Fb, G+...)
- 記事のいいね機能
- 検索機能(タグ, タイトル, 本文)
- マイページの実装
- キャッシュで高速化
- 親しみやすいデザイン

## ログイン機能
メールアドレスでのログインを実装しました。
ログイン機能は`Devise`を用いて実装し、ユーザネームとサムネイルもカラムとして保持するようにしました。

![log-in scene](https://github.com/hyde2able/techbo/blob/master/images/login.png?raw=true)

## 画像投稿
paperclipを用いて、AWS S3に画像を保存しています。
パフォーマンス向上のために`lazyload.js`を用いて遅延ロードを実装しています。
また、画像投稿のさいに、変更後の画像をすぐに確認できるようにプレビュー機能を実装しました。

![upload scene](https://github.com/hyde2able/techbo/blob/master/images/upload.png?raw=true)

## 記事投稿
画像に紐付いた記事を投稿できます。
記事には本文のほか、タグを登録出来ます。
本文はマークダウンで書いた記事をプレビュータブで確認できます。
記事を「まだ公開しない」にチェックすると、記事はドラフト状態になって、共有リンクを発行します。

![upload-entry scene](https://github.com/hyde2able/techbo/blob/master/images/upload-entry.png?raw=true)

## 記事にコメント機能
投稿されている記事に誰でもコメントが出来ます。
ログインユーザはサムネイルや投稿名が勝手に補完されますが、これは編集が可能です。
投稿コメントはAjax処理で投稿されるので、画面遷移はしません。
また、本文が何も入力されていないなど、バリデーションに引っかかった場合は、非同期でエラー文章を表示します。

![comment](https://github.com/hyde2able/techbo/blob/master/images/comment.png?raw=true)


## シェア機能
記事はTwitetr, Facebook, Google +,Hacker Newsに簡単にシェア出来ます。

## 記事のいいね機能
ログインユーザであれば記事にいいね！を出来ます。
マイページでいいね！をした記事の一覧、自分の投稿記事の総いいね数などが見れます。
いいね！はAjax処理で実行され、いいねカウントは`counter_culture`でキャッシュを取っている
ため、いいねをした時に回数を更新することで、無駄なSQLを吐かないようにしています。

## 検索機能
投稿記事のタグでの完全一致検索とタイトル、本文のあいまい検索で実装しています。

## マイページの実装
ログインユーザであれば、ヘッダー右側にマイページへのリンクが表示されます。
マイページでは
- ユーザ情報
- 投稿記事数
- 投稿記事の合計いいね数
- 投稿記事の合計View数
- 投稿記事一覧
- いいね記事の一覧
- アクティビティログ
を確認することが出来ます。

親しみの持ちやすいUIを意識しました。

![mypage scene](https://github.com/hyde2able/techbo/blob/master/images/mypage.png?raw=true)

## キャッシュで高速化
ログイン時のヘッダーのサムネイル画像部分や、記事一覧などはフラグメントキャッシュを取っています。

## 親しみやすいデザイン
CSS Frameworkとして`Semantic ui`を採用しました。
色々なモジュールなどがあるので、それらを組み合わせて白を基調としたシンプルなUIを目指しました。
