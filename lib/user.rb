class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String
  property :name, String

  has n, :accounts
end
