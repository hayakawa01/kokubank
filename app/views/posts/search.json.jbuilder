json.array! @childrens do |children|
  json.id children.id
  json.name children.name
end

json.array! @grandchildrens do |grandchildren|
  json.id grandchildren.id
  json.name grandchildren.name
end