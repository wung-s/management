class Mark < ActiveRecord::Base
	belongs_to :student
	belongs_to :course


	def self.import(file, course_id, department_id)
		# xlsx =  Roo::Spreadsheet.open(file.path)
		# 
		begin
  			# excel_file = file.original_filename =~ /.*\.xlsx$/i ? Roo::Excelx.new(file.path) : Roo::Excel.new(file.path)
  			course_association = CourseAssociation.where(course_id: course_id, department_id: department_id).take 

  			# debugger
  			excel_file = Roo::Excelx.new(file.path) 
			
			header = excel_file.row(1).slice(0,3)

			header.map! do |word|
				word.strip.downcase
			end

			
			faulty_rows = Array.new

			(2..excel_file.last_row).each do |key, val|
			
				row = Hash[[header, excel_file.row(key).slice(0,3)].transpose]
			
				if row[header[1]].is_a? Numeric and row[header[2]].is_a? Numeric then
					student = Student.find_by! regno: row[header[0]]
					course = Course.find(course_id)
					marks = Mark.where(course_id: course_id, student_id: student.id).take || new
					marks.internal = row[header[1]]
					marks.external = row[header[2]]
					marks.total = marks.internal + marks.external

 					case 
						when marks.total >= 70
							marks.grade = 'O'
						
						when marks.total < 70 && marks.total >= 60 
							marks.grade = 'A'
 						
						when marks.total < 60 && marks.total >=55
							marks.grade = 'B'
						
						when marks.total < 55 && marks.total >= 50
							row.grade = 'C'
						
						when marks.total < 50 && marks.total >= 45
							marks.grade = 'D'
						
						when marks.total < 45 && marks.total >=40
							marks.grade = 'E'
						
						when marks.total < 40 && marks.total >=0
							marks.grade = 'F'
						else 
							faulty_rows.push(key)
					end		

					all_grade_point_info = GradePoint.all.to_a
					grade_point = {}
					all_grade_point_info.each do | row |
					grade_point[row.grade.to_s] = row[:point]
					end

					 marks.credit_point = course_association.credit_hour * grade_point[marks.grade] 
					 marks.student = student
					 marks.course = course
					 marks.save

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
