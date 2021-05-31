class Subject < ActiveHash::Base
  self.data =[
    {id: 1, name: '--'},
    {id: 2, name: '国語'},
    {id: 3, name: '算数'},
    {id: 4, name: '理科'},
    {id: 5, name: '社会'},
    {id: 6, name: '英語・外国語'},
    {id: 7, name: '音楽'},
    {id: 8, name: '体育'},
    {id: 9, name: '図工'},
    {id:10, name: '家庭'},
    {id:11, name: '生活'},
    {id:12, name: '総合'},
    {id:13, name: '道徳'},
    {id:14, name: '学活'},
    {id:15, name: 'その他'}
  ]

  include ActiveHash::Associations
    has_many :posts
end