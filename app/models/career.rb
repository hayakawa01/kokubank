class Career < ActiveHash::Base
  self.data =[
    {id: 1, name: '--'},
    {id: 2, name: '1~3年'},
    {id: 3, name: '3~5年'},
    {id: 4, name: '5~10年'},
    {id: 5, name: '10~20年'},
    {id: 6, name: '20年以上'}
  ]
  
  include ActiveHash::Associations
  has_many :users

end