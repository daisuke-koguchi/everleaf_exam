class Task < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true 
  validates :deadline, presence: true
  enum status: {'未着手': 0, '着手中': 1, '完了': 2}
  scope :search_name, -> (count){ where('name LIKE ?', "%#{count}%") }
  scope :search_status, ->(count){ where(status: "#{count}") }
  scope :deadline, ->{all.order(deadline: "DESC")}
  scope :created_at, ->{all.order(created_at: "DESC")}
  enum priority: {' ':0 ,'高':1, '中': 2, '低':3}
  scope :priority, ->{all.order(priority: "ASC")}
  paginates_per 10   
end
