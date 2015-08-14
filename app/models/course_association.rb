class CourseAssociation < ActiveRecord::Base
	belongs_to :course
	belongs_to :department
end
