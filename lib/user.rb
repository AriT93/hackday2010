class HdUser
  include DataMapper::Resource

  property :id, Serial
  property :email, String
  property :name, String

  has n, :accounts
  has n, :policies
  has n, :messages
  has n, :claims

  after :create, :populate


  def populate
    ptype = %w{ auto life umbrella fire renter}
    cstat = %w{ pending review closed canceled open }
    5.times do
      a = self.accounts.new
      a.balance = rand(3000.50)

      p = self.policies.new
      p.policyType = ptype[rand(4)]

      c = self.claims.new
      c.status = cstat[rand(4)]
      c.amount = rand(600.98)

      m = self.messages.new
      m.text = "this is a random message"
      m.from = "The Boss"
      m.subject = "test message"
    end
  end
end
