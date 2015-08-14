class Department < ActiveRecord::Base
	has_many :students
	has_many :courses, through: :course_associations
end
