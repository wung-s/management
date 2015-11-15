class Course < ActiveRecord::Base
	has_many :course_associations, inverse_of: :course
	has_many :departments, through: :course_associations
	has_many :marks

	validates :code, presence: true
	validates :name, presence: true
	validates_associated :course_associations

	accepts_nested_attributes_for :course_associations, reject_if: :reject_course_associations


 	private

 	def reject_course_associations(attributed)
		attributed['semester'].blank? or attributed['credit_hour'].blank? 
 	end

 	
end
