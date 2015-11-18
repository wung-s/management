class Student < ActiveRecord::Base
	belongs_to :department
	# belongs_to :state
	belongs_to :country
	has_many :marks, dependent: :destroy
	#set the no of entries to be retrieved using will_paginate
	self.per_page = 10


	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

	validates :first_name, presence: true
	validates :last_name, presence: true
	validates :email, format: {with: VALID_EMAIL_REGEX}
	validates :address, presence: true
	validates :pincode, presence: true
	validates :emergency_no, presence: true,
							 numericality:  {only_integer: true, greater_than_or_equal_to: 0}
	validates :department_id, presence: true,
							 numericality:  {only_integer: true, greater_than_or_equal_to: 0}


	validates :country_id, presence: true,
							 numericality:  {only_integer: true, greater_than_or_equal_to: 0}
    validates :state_id, presence: true,
    					 numericality:  {only_integer: true, greater_than_or_equal_to: 0},
    					 if: :country_is_india?

    def country_is_india?
    	return true if country_id == 1
    	false
    end

	def generate_regno(department_id)
		#the generated length would be 1+3+4+5 = 13 characters
		student_count = Student.where(department_id: department_id).count
		student_count += 1
 		regno = "1" + "%03d" % department_id + "%04d" % Time.now.year + "%05d" % student_count
  	end

end