class Grade < ActiveHash::Base
  self.data = [
    {id: 1, name: "--"},
    {id: 2, name: "1年"},
    {id: 3, name: "2年"},
    {id: 4, name: "3年"},
    {id: 5, name: "4年"},
    {id: 6, name: "5年"},
    {id: 7, name: "6年"},
    {id: 8, name: "特別支援"},
    {id: 9, name: "学年共通"}
  ]

  include ActiveHash::Associations
    has_many :posts
end