class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # Define the primary key for JWT authentication
  def self.primary_key
    '_id'
  end

  # Devise modules
  devise :database_authenticatable, :registerable,
         :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Relationships
  has_many :messages

  ## Validations
  validates :email, presence: true, uniqueness: true
end
