class Property < ActiveRecord::Base
  self.table_name = "propertys"
  validates_presence_of :name, :type, :value
  belongs_to :user
end
