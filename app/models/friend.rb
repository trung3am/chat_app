class Friend < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates_uniqueness_of :user_id, scope: :f_id
  validates :f_id, presence: true
  validate :cannot_add_self
  validate :f_id_exist?

  private

  def cannot_add_self
    errors.add(:user_id, 'You cannot add yourself as a friend.') if f_id == user_id
  end

  def f_id_exist?
    errors.add(:f_id, 'friend not exist.') if !User.find_by_id(self.f_id)
  end
end