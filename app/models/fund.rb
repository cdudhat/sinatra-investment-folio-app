class Fund < ActiveRecord::Base
  validates_presence_of :name, :type, :value
  belongs_to :user
end
