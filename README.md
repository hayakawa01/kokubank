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
has_many: posts
has_many: comments


## posts テーブル

| Column                 | Type       | Options                  |
| ---------------------- | ---------- | ------------------------ |
| class_name             | string     | null: false              |
| detail                 | text       | null: false              |
| grade_id               | integer    | null: false              |
| subject_id             | integer    | null: false              |
| unit_id                | integer    | null: false              |
| user                   | references | foreign_key: true        |

### Association
belongs_to: user
has_many: comments


## comments テーブル

| Column                 | Type       | Options                  |
| ---------------------- | ---------- | ------------------------ |
| text                   | string     | null: false              |
| user                   | references | foreign_key: true        |
| post                   | references | foreign_key: true        |

### Association
belongs_to: user
belongs_to: post
