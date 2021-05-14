class User < ApplicationRecord
  has_secure_password
  has_many :messages
  validates :username,uniqueness: true ,presence: true, length: {minimum: 3, maximum: 25}
end
