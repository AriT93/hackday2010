class Message
  include DataMapper::Resource

  property :id, Serial
  property :text, Text
  property :dateStamp, Date, :default => Date.today.strftime('%m/%d/%Y')
  property :from, String
  property :subject, String
end
