module StudentsHelper

	def to_show
		return 'block' if @student.errors.messages.empty?
		return 'none'
	end

	def to_show_error
		return 'none' if @student.errors.messages.empty?
		return 'block'
	end
end
