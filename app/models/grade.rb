class Grade < ApplicationRecord
  has_many: posts
  has_ancestry

  validates :name, presence: true
end
