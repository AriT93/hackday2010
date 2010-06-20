class Policy
  include DataMapper::Resource

  property :id, Serial
  property :policyNum, String
  property :policyType, String

  belongs_to :hd_user

  before :save, :add_policyNum

  def add_policyNum
    self.policyNum ||= "IBPOL00#{Policy.count + 1}"
  end
end
