class Profile
  include Mongoid::Document

  field :name, type: String
  field :last_name, type: String

  embedded_in :user
end
