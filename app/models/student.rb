class Student < ActiveRecord::Base
	belongs_to :department
	belongs_to :state
	has_many :marks, dependent: :destroy

	def generate_regno(department_id) 
		#the generated length would be 3+4+5 = 12 characters
 		regno = "%03d" % department_id + "%04d" % Time.now.year + "%05d" % Student.where(department_id: department_id).count
  	end
end
