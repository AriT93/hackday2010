class Account
  include DataMapper::Resource

  property :id, Serial
  property :accountNum, Integer
  property :balance, Float

  belongs_to :user
end
