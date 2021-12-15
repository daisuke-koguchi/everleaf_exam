class User < ApplicationRecord
  before_update :must_not_update_last_one_admin
  before_destroy :must_not_destroy_last_one_admin 
  has_many :tasks ,dependent: :destroy
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true 
  validates :password, presence: true

  def must_not_update_last_one_admin
    if User.where(admin: true).count == 1 && self.admin == false
      binding.pry
      throw :abort
    end
  end
  def must_not_destroy_last_one_admin 
    if User.where(admin: true).count <= 1 && self.admin == true
      binding.pry
      throw :abort
    end
  end
end
