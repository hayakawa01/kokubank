class Unit < ActiveHash::Base
  self.dara = [
    {id: 1, name: "--"},
    {id: 2, name: "漢字"},
    {id: 3, name: "かけ算"},
    {id: 4, name: "大地の変化"},
    {id: 5, name: "大正〜昭和"},
    {id: 6, name: "Unit８ 好きな食べ物は？"},
    {id: 7, name: "鑑賞"},
    {id: 8, name: "水泳"},
    {id: 9, name: "版画"},
    {id:10, name: "調理実習（ゆでる）"},
    {id:11, name: "学校たんけん"},
    {id:12, name: "自主・自立"},
    {id:13, name: "伝統を受け継ぐ"}
  ]

  include ActiveHash::Associations
    has_many :posts
end