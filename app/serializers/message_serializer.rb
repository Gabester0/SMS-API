class MessageSerializer
  include JSONAPI::Serializer
  
  attributes :to_phone_number, :content, :status

  attribute :id do |message|
    message._id.to_s
  end

  attribute :created_at do |message|
    message.created_at.iso8601
  end

  belongs_to :user
end
