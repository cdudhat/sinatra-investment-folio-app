class Fund < ActiveRecord::Base
  validates_presence_of :name, :category, :value
  belongs_to :user
end
