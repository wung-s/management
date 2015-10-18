class Department < ActiveRecord::Base
	has_many :students
	has_many :course_associations, inverse_of: :department
	has_many :courses, through: :course_associations
end
