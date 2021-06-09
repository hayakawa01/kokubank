class RemoveSubjectIdFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :subject_id, :integer
  end
end
