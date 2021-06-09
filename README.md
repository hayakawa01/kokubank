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


## posts テーブル

| Column                 | Type       | Options                  |
| ---------------------- | ---------- | ------------------------ |
| class_name             | string     | null: false              |
| detail                 | text       | null: false              |
| grade                  | references | foreign_key: true        |
| user                   | references | foreign_key: true        |

### Association
belongs_to :user
has_many :comments
belongs_to :grade

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


## subjects テーブル

| Column                 | Type       | Options                  |
| ---------------------- | ---------- | ------------------------ |
| name                   | string     | null: false              |
| grade                  | references | foreign_key: true        |


## units テーブル

| Column                 | Type       | Options                  |
| ---------------------- | ---------- | ------------------------ |
| name                   | string     | null: false              |
| subject                | references | foreign_key: true        |

