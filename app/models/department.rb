class Department < ActiveRecord::Base
  has_many :students
  has_many :course_associations, inverse_of: :department
  has_many :courses, through: :course_associations

  def self.unassociated(course_id)
    res = Course.find(course_id).departments.to_a.map(&:serializable_hash)
    associated_departments = []
    res.each do |element|
      associated_departments << element.values.first 
    end 
  
    where.not(:id => associated_departments) 
  end
end
