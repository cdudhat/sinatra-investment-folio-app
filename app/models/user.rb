class User < ActiveRecord::Base
  validates :name, :email, presence: true
  has_secure_password
  has_many :stocks
  has_many :funds
  has_many :propertys
  has_many :products
end
