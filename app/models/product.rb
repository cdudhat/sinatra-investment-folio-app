class Product < ActiveRecord::Base
  validates_presence_of :name, :type, :value
end