class Grade < ApplicationRecord
  has_many :posts
  has_ancestry

  validates :name, presence: true

  def set_posts
    #親カテゴリの場合
    if self.root?
      start_id = self.indirects.first.id
      end_id = self.indirects.last.id
      posts = Post.where(grade_id: start_id..end_id)
      return posts

      #子カテゴリの場合
    elsif self.has_children?
      start_id = self.children.first.id
      end_id = self.children.last.id
      posts = Post.where(grade_id: start_id..end_id)
      return posts
    
      #孫カテゴリの場合
    else 
        return self.posts
    end
  end
end
