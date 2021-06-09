class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string      :class_name, null:false
      t.text        :detail,     null:false
      t.references  :grade,      foreign_key: true
      t.references  :user,       foreign_key: true
      t.timestamps
    end
  end
end
