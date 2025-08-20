class MessageSerializer < ActiveModel::Serializer
  attributes :id, :to_phone_number, :content, :status, :created_at

  belongs_to :user

  def id
    object._id.to_s
  end

  def created_at
    object.created_at.iso8601
  end
end
