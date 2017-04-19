class Stock < ActiveRecord::Base
  validates :name, :price, :number, presence: true
  belongs_to :user
end
