class Student < ActiveRecord::Base
	belongs_to :department
	belongs_to :state
	has_many :marks, dependent: :destroy
end
