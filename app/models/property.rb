class Property < ActiveRecord::Base
  self.table_name = "propertys"
  validates_presence_of :name, :type, :value
end
