class RemoveUnitIdFromPosts < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :unit_id, :integer
  end
end
