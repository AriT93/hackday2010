class HdUser
  include DataMapper::Resource

  property :id, Serial
  property :email, String
  property :name, String

  has n, :accounts
  has n, :policies
  has n, :messages
  has n, :claims
end
