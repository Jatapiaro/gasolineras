class UserSerializer < ActiveModel::Serializer
  attributes :id,:name,:last_name,:second_last_name,:email
end
