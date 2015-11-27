class Mark < ActiveRecord::Base
  belongs_to :student
  belongs_to :course

  validates :student_id, :internal, :external, presence: true
  validates :internal, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 20}
  validates :external, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 60} 

  def self.import(file, course_id, department_id)
    # xlsx =  Roo::Spreadsheet.open(file.path)
    begin
      # excel_file = file.original_filename =~ /.*\.xlsx$/i ? Roo::Excelx.new(file.path) : Roo::Excel.new(file.path)
      course_association = CourseAssociation.where(course_id: course_id, department_id: department_id).take 
      return 'no association' if course_association.nil?
      # debugger
      excel_file = Roo::Excelx.new(file.path) 

      header = excel_file.row(1).slice(0,3)
      header.map! do |word|
        word.strip.downcase
      end
      
      faulty_rows = Array.new
      all_grade_point_info = GradePoint.all.to_a
      (2..excel_file.last_row).each do |key, val|

        row = Hash[[header, excel_file.row(key).slice(0,3)].transpose]
     
        if row[header[1]].is_a? Numeric and row[header[2]].is_a? Numeric then
          student = Student.find_by regno: row[header[0]].to_i
          if student.nil?
            faulty_rows.push(key)
            next
          end
             
          course = Course.find(course_id)
          mark = Mark.where(course_id: course_id, student_id: student.id).take || new
          mark.internal = row[header[1]].to_i
          mark.external = row[header[2]].to_i
          mark.total = mark.internal + mark.external

          case 
          when mark.total >= 70
            mark.grade = 'O'

          when mark.total < 70 && mark.total >= 60 
            mark.grade = 'A'

          when mark.total < 60 && mark.total >=55
            mark.grade = 'B'

          when mark.total < 55 && mark.total >= 50
            row.grade = 'C'

          when mark.total < 50 && mark.total >= 45
            mark.grade = 'D'

          when mark.total < 45 && mark.total >=40
            mark.grade = 'E'

          when mark.total < 40 && mark.total >=0
            mark.grade = 'F'
          else 
            faulty_rows.push(key)
          end		
    
          grade_point = {}
          all_grade_point_info.each do | row |
            grade_point[row.grade.to_s] = row[:point]
          end

          mark.credit_point = course_association.credit_hour * grade_point[mark.grade] 
          mark.student = student
          mark.course = course
          faulty_rows.push(key) unless mark.save
        else
          faulty_rows.push(key)
        end
      end  

    rescue Exception => error
      faulty_rows.push(error)
    end 

    return faulty_rows

  end

end
