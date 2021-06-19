

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
