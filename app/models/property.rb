class Property < ActiveRecord::Base
  self.table_name = "propertys"
  validates :name, :category, :value, presence: true
  belongs_to :user
end
