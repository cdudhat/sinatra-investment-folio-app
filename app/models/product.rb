class Product < ActiveRecord::Base
  validates :name, :category, :value, presence: true
  belongs_to :user
end
