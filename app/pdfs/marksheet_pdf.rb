# require "prawn"
# require "prawn/table"
class MarksheetPdf < Prawn::Document
	# def initialize(user)
	def initialize()	
		super({top_margin: 130, page_size: 'A4'})
		# @user = user
		@slno = 001
		sem1 = "I"
		sem2= "II"
		@faculty = 'Business Administration'
		@session = 'I & II(2014-2015)'
		@examination = 'Master of Business Administration(MBA)'
		@medium = 'English'
=begin
		font_families.update("Old English" => {
 												normal: "OldeEnglish.ttf"}, 
							"English Towne" => {
												normal: "EnglishTowne.tff"})
=end

		header_info sem1
		show_current_semester sem1
		subj_header
		subject_marks

		move_down 25
		show_current_semester sem2
		subj_header
		subject_marks

		footer
		move_down 5
		show_warning
#		test

	end

	def statement 
		text "Statement Of Marks And Grades", size: 40, style: :bold
	end
	def header_info sem
		data =[["Sl. No:#{@slno}","Status: Regular",{content: "Semester/Academic Session: #{sem}"}], 
				["Faculty:#{@faculty}", {content: "Examination: #{@examination}", colspan: 2}], 
				["Name: #{@name}","ID: \##{@id}", "Medium: #{@medium}"]]
		
		table data, {:position => :center, :column_widths => [184,164,174],:cell_style => {border_width: 0, size: 11}}

	end

	def subj_header 
		data = [["C.Code","Course Title", "CR", {content: "Marks", colspan: 3}, "GRD", "G.PT", "NA"],
				["","","","Int <font size='8'> 16/40</font>","Ext <font size='8'>24/60</font>","Total <font size='8'>40/100</font>", "","",""]
				]
		table data, {:position => :center,:cell_style => {border_width: 1,inline_format: true, size: 10}}  do
			self.column_widths= {0 => 60,1 => 210,2 => 30,3 => 36, 4 => 36,5 => 40, 6 => 40,7 => 35, 8 => 35}
			rows(0).font_style = :bold
			rows(1).font_style = :italic			
			columns(2..8).align = :center
		end
	
	end

	def subject_marks
		marks = make_table [[1,2,3,4,5,6,7,8,9],
							[11,12,13,14,15,16,17,18,19]]
		data = [ 
				["AAA111", "Financial Accounting", 3, "--"," --"," --", "C", 12, 1],
				["AAA222", "Financial Accounting", 3, "--"," --"," --", "C", 12, 1],
				["AAA333", "Financial Accounting", 3, "--"," --"," --", "C", 12, 1],
				["AAA333", "Financial Accounting", 3, "--"," --"," --", "C", 12, 1],
				["AAA333", "Financial Accounting", 3, "--"," --"," --", "C", 12, 1],
				["AAA333", "Financial Accounting", 3, "--"," --"," --", "C", 12, 1],
				["","","","","","","","",""],
				["","","","","","","","",""],
				["","","","","","","","",""],
				["","<b>Grand Total Credit Hours/Grand Total Marks/Grand Total Grade Points</b>",15, {content: 370.to_s, colspan: 3, align: :right}, "", 96, ""],
				["","<b>CGPA</b>",6.4, {content: "<b>Average:</b> ", colspan: 3}, "<b>SGPA 5.0</b>", 96, ""],
				["<b>RESULT</b>","PASS","",{content: "<i>**N.A: Number of Attempt</i> ", colspan: 6, align: :right}],
				
				]
#		table data, width: 300,{:position => :center, :column_widths => [100,200,1],:cell_style => {border_width: 1}} 
		table data, {:position => :center,:cell_style => {inline_format: true, size: 10, height: 15, padding: [0,0,0,4]}}  do
			self.column_widths= {0 => 60,1 => 210,2 => 30,3 => 36, 4 => 36,5 => 40, 6 => 40,7 => 35, 8 => 35}
			#row(0).font_style = :bold
			cells.borders = [:left]
			columns(8).borders = [:right,:left]
			columns(2..8).align = :center
			rows(0).padding = [4,0,0,4]
			rows(-3).borders = [:right,:left,:top]
			rows(-2).borders = [:right,:left,:top]
			rows(-1).borders = [:bottom,:left, :right,:top]
			#row(3).height = 5
		end
	end

=begin
	def test
		data = [[1,2,3],[4,5,6]]
		table data, width: 520 do 
			row(0).font_style = :bold
			
		end
	end
=end
	def show_current_semester sem
		text "SEMESTER - #{sem}", size: 12, style: :bold, align: :center
	end

	def show_result
	#	font("#{Prawn::DATADIR}/fonts/OldeEnglish.ttf") do
 	#	text "RESULT."
	#	end
		text "RESULT", size: 12, style: :bold
	end

	def footer
		t = Time.now
		d = Date.today
		@date = d.strftime("%B") + ", " + t.year.to_s
		
		data = [["Date: "+ @date, ""], 
				["Place: Pune",{content: "<font name='Helvetica-Bold'>Controller Of Examination, SAU</font>", align: :right}]]
		table data, {position: :left, column_widths: [123,400],cell_style: {border_width: 0, font_style: :bold, inline_format: true}} do 

			end

	end

	def show_warning
		str = "<u>*** Any Alteration or overwriting is illegal and makes this statemt of Marks and Grades Invalid ***</u>"
		text str, size: 10, style: :italic, align: :center, inline_format: true
		# text str, size: 10, style: "Times-Roman", align: :center
	
	end





















	def user_name
		text "User name is: #{@user.name}", size: 40, style: :bold
	end

	def grade_report
		text "GRADE REPORT"
	end

	def student_info
		data = [["SI.NO:","Date:"],
				["Faculty:","Academic Session/Semester:"],
				["Name:","Department:"],
				["ID No:",""]]
		table data, :position => :center, :cell_style=>{:padding => 10}
	end

	def line_items
		#move_down 20
	#	table ([[1,2],[3,4]])
		
		data = [["INTERNAL","EXTERNAL","CREDIT HOURS","TOTAL HRS","CREDIT POINTS"],
			    [33,55,3,20,4]]
		table data,:position => :center, :cell_style =>{:padding=> 10}	    
		#table data,:position => :center, :cell_style =>{:border_width => 0,:padding=> 5}
		#table data,:cell_style =>{:border_width => 0}
	end

end
