class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :to_phone_number, type: String
  field :from_phone_number, type: String
  field :content, type: String
  field :status, type: String, default: 'queued'
  #'queued', 'sending', 'sent', 'failed', 'delivered', 'undelivered', 'receiving', 'received'

  belongs_to :user

  validates :to_phone_number, presence: true,
                    format: { 
                      with: /\A\+[1-9]\d{1,14}\z/, 
                      message: "must be in E.164 format (e.g., +14155552671)" 
                    }
  validates :from_phone_number, presence: true
  validates :content, presence: true,
                     length: { maximum: 250, message: "must not exceed 250 characters" }
  validates :user, presence: true

  before_validation :set_twilio_number

  private

  def set_twilio_number
    self.from_phone_number ||= Rails.application.config.x.twilio[:phone_number]
  end
end
