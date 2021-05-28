class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :friends, dependent: :destroy
  has_many :messages, dependent: :destroy
  validates :username, uniqueness: {case_sensitive: false}, presence: true, length: {minimum: 3, maximum: 25}
  has_many :group_messages, through: :messages
  validates :about, length: {maximum: 70}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, 
            presence: true, 
            uniqueness: {case_sensitive: false}, 
            length: {maximum: 105},
            format: {with: VALID_EMAIL_REGEX}

    def self.execute_sql(*sql_array)     
      connection.execute(send(:sanitize_sql_array, sql_array))
    end
end
