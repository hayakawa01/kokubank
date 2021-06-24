# アプリ概要

### アプリ名
KOKUBANK〜黒板という財産を貯める場所〜

### 概要
教員の指導力向上と多忙感の解消を目的とした板書写真の共有サービスです。<br>
実践に対して質問や意見交換などのやり取りできるコメント機能もあるため、全国の先生方とつながることができます。
なお、レスポンジブ対応しておりますので、スマホ、タブレットからもご確認いただけます。<br>
**＊本サービスは小学校教員を対象です。**

<br>

# 本番環境URL
[none]()

<Basic認証><br>
username: admin<br>
password: 2222

<br>

# 制作背景
自身の元教員経験とペルソナに該当する若手教員へのヒアリングから当サービスの作成を考案・企画しました。<br>
2021年、教職員の長時間労働が問題となっている。プログラミング教育に始まる次々と生み出される「〇〇教育」は、長時間労働の原因の1つとして挙げられる。<br>
実際、国際教員指導環境調査では、日本の小学校教員の1日あたりの平均勤務時間は約11時間と、参加国中で最長となっており、
同調査の「教員の悩み」の項目には、授業の準備をする時間が足りない考えている教員が約95％おり、多くの教員が生活にゆとりがないと感じている。
また、働き方改革が進みつつあるものの、言葉だけ独り歩きし、家で行う「持ち帰り仕事」が増加しているという現状もある。<br>
これらの事実を踏まえ、当サービス"KOKUBANK"で、板書写真を通じた授業実践の共有のためのプラットフォームを設けることで、指導力の向上と多忙感の軽減に貢献したいと思い作成に踏み切った。

<br>
<br>

|教員の勤務時間について|教員の悩み・不満について|
|---|---|
|<img width="705" alt="スクリーンショット " src="">|
<img width="834" alt="スクリーンショット" src="">|

参考：リンク<br>
参考：リンク



<br>


# 工夫した点

### 開発工程
 - 実際の開発現場を想定して、機能ごとにブランチを切って開発を進め、プルリクエストも活用しマージまで行った。
 - ペルソナである**若手教員へヒアリング**を行い、必須機能を選定。

### 機能ポイント

 - ペルソナが満足する機能の実装。
 - ユーザビリティを意識した実装（Ajax,カテゴリ検索機能等）。
 - タブレット、スマーフォンでも崩れないレスポンシブ対応。

<br>

# 機能一部紹介

### 授業写真の投稿と共有
[![Image from Gyazo](https://i.gyazo.com/0c04243eb7e4788aad0cfc7546443d93.gif)](https://gyazo.com/0c04243eb7e4788aad0cfc7546443d93)

- 画像のプレビューが可能。
- 投稿をそのまま反映（改行等）することが可能。
- 学年・教科・単元まで絞り込めるプルダウンリストを作成

### 通知機能
[![Image from Gyazo](https://i.gyazo.com/f3c613b90ec5497ab79610a5d0e7beaf.gif)](https://gyazo.com/f3c613b90ec5497ab79610a5d0e7beaf)

- 他のユーザーの「コメント」や「いいね」に対して通知を実行。
- 通知一覧からコメントされた投稿やコメントしたユーザーへ遷移可能。
- ユーザーが確認していない新通知の場合通知アイコンが変化。

### レスポンシブ対応
[![Image from Gyazo](https://i.gyazo.com/4fd4eb541314d9ba274dd590771123e7.gif)](https://gyazo.com/4fd4eb541314d9ba274dd590771123e7)

- スマートフォン、タブレット、PC全てのデバイスか閲覧可能。
- スマートフォンとタブレットの場合、固定ヘッダーに変化、検索窓を常に表示。


<br>

# 機能一覧

- ユーザー登録、ログイン機能(devise)
- ユーザ編集機能
- 授業実践投稿機能
  - 画像投稿機能
  - カテゴリプルダウン選択機能
- 画像プレビュー機能
- 投稿編集機能
- 投稿削除機能
- いいね機能(Ajax)
  - 自己いいね一覧機能
  - いいね数表示機能
- コメント機能
  - コメント数表示機能
- ページネーション機能(kaminari)
- パンくずリスト機能(gretel)
- 検索機能
  - キーワード検索
  - カテゴリ検索
- 通知機能
  - コメント通知
  - いいね通知
- レスポンシブ対応
  - タブレット、スマートフォン対応
  - ハンバーガーメニュー
  - 固定検索窓


 
<br>

# 使用技術

- Ruby 2.6.5
- Ruby on Rails 6.0.0
- MySQL 5.6.51
- Nginx
- AWS
  - VPC
  - EC2
  - S3
  - RDS
- RSpec

<br>


# DB 設計
<img src="assets/images/KOKUBANK ER.png" height="700">

<br>

# テスト

- RSpec
  - 単体テスト(model)
  - 機能テスト(request)
  - 統合テスト(system)

<br>

# 今後の課題点
 - よりユーザー同士の関係をさらに深くにするためのDM機能やチャットルーム機能の実装
 - 授業の詳細をより伝わりやすくする（文字の装飾など）機能の実装
 - 「DENSI-KOKUBANK」の追加（電子黒板の普及率の増加から電子黒板共有サービス）
 
<br>

# テーブル設計

## users テーブル

| Column                 | Type    | Options                  |
| ---------------------- | ------- | ------------------------ |
| nickname               | string  | null: false              |
| email                  | string  | null: false, unique:true |
| encrypted_password     | string  | null: false              |
| family_name            | string  | null: false              |
| first_name             | string  | null: false              |
| family_name_kana       | string  | null: false              |
| first_name_kana        | string  | null: false              |
| prefecture_id          | integer | null: false              |
| career_id              | integer | null: false              |
| favorite_subject_id    | integer | null: false              |
| introduction           | text    |                          |

### Association
has_many :posts
has_many :comments
has_many :likes
has_many :active_notifications
has_many :passive_notifications

## posts テーブル

| Column                 | Type       | Options                  |
| ---------------------- | ---------- | ------------------------ |
| class_name             | string     | null: false              |
| detail                 | text       | null: false              |
| grade                  | references | foreign_key: true        |
| user                   | references | foreign_key: true        |

### Association
belongs_to :user
belongs_to :grade
has_many :comments
has_many :likes
has_many :notifications

## comments テーブル

| Column                 | Type       | Options                  |
| ---------------------- | ---------- | ------------------------ |
| text                   | string     | null: false              |
| user                   | references | foreign_key: true        |
| post                   | references | foreign_key: true        |

### Association
belongs_to :user
belongs_to :post


## likes テーブル

| Column                 | Type       | Options                  |
| ---------------------- | ---------- | ------------------------ |
| text                   | string     | null: false              |
| user                   | references | foreign_key: true        |
| post                   | references | foreign_key: true        |

### Association
belongs_to :user
belongs_to :post


## grades テーブル

| Column                 | Type       | Options                  |
| ---------------------- | ---------- | ------------------------ |
| name                   | string     | null: false              |
| ancestry               | string     |                          |

### Association
has_many :posts
has_ancestry


## notifications テーブル

| Column                 | Type       | Options           |
| ---------------------- | ---------- | ----------------- |
| visiter_id             | integer    | foreign_key: true |
| visited_id             | integer    | foreign_key: true |
| post_id                | integer    |                   |
| comment_id             | integer    |                   |
| action                 | string     |                   |
| checked                | boolean    | null: false       |

### Association
belongs_to :post
belongs_to :comment
belongs_to :visiter
belongs_to :visited
