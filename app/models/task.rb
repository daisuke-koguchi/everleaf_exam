class Task < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true 
  validates :deadline, presence: true
  enum status: {'未着手': 0, '着手中': 1, '完了': 2}
  scope :search_name, -> (count){ where('name LIKE ?', "%#{count}%") }
  scope :search_status, ->(count){ where(status: "#{count}") }
  scope :deadline, ->{all.order(deadline: "DESC")}
  scope :created_at, ->{all.order(created_at: "DESC")}
end
