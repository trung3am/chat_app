class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group_message
  validates :body, presence: true
  scope :custom_display, -> { order(:created_at).last(20)}
  
  def self.execute_sql(*sql_array)     
    connection.execute(send(:sanitize_sql_array, sql_array))
  end
  
end

