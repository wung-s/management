class CourseAssociation < ActiveRecord::Base
	belongs_to :course, inverse_of: :course_associations
	belongs_to :department

	accepts_nested_attributes_for :department

	
end
