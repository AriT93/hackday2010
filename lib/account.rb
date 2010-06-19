class Account
  include DataMapper::Resource

  property :id, Serial
  property :accountNum, Integer
  property :balance, Float

  belongs_to :hd_user

  before :save, :add_accountNum

  def add_accountNum
    self.accountNum ||= Account.count + 1
  end
end
