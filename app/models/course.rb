class Course < ActiveRecord::Base
	has_many :departments, through: :course_associations
	has_many :marks
end
