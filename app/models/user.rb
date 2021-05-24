class User < ApplicationRecord
  has_secure_password
  has_many :friends, dependent: :destroy
  has_many :messages, dependent: :destroy
  validates :username, uniqueness: {case_sensitive: false}, presence: true, length: {minimum: 3, maximum: 25}
  has_many :group_messages, through: :messages
end
