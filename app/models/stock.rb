class Stock < ActiveRecord::Base
  validates_presence_of :name, :price, :number
  belongs_to :user
end
