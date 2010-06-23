class Claim
  include DataMapper::Resource

  property :id, Serial
  property :claimNum, String
  property :status, String
  property :amount, Float

  belongs_to :hd_user

  before :save, :add_claimNum

  def add_claimNum
    self.claimNum ||= "IBCLM00#{Claim.count + 1}"
  end
end
