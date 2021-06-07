class RemoveGradeIdFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :grade_id, :integer
  end
end
