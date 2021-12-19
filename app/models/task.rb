class Task < ApplicationRecord
  has_many :labellings, dependent: :destroy ,foreign_key:'task_id'
  has_many :labels, through: :labellings
  belongs_to :user
  validates :name, presence: true
  validates :description, presence: true 
  validates :deadline, presence: true
  enum status: {'選択して下さい':0, '未着手':1, '着手中':2, '完了':3}
  scope :search_name, -> (count){ where('name LIKE ?', "%#{count}%") }
  scope :search_status, ->(count){ where(status: "#{count}") }
  scope :deadline, ->{all.order(deadline: "DESC")}
  scope :created_at, ->{all.order(created_at: "DESC")}
  enum priority: {'選択':0 ,'高':1, '中':2, '低':3}
  scope :priority, ->{all.order(priority: "ASC")}
  paginates_per 10   
end
