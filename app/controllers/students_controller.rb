class StudentsController < ApplicationController
  def index
    respond_to do |format|
          format.html
          format.json { render json: StudentDatatable.new(view_context) }
    end
  end

  def create
# begin
    # debugger
    @student = Student.new(student_params)
    @student.regno = @student.generate_regno(params[:student][:department_id])
    if @student.save
      # @students = Student.paginate(page: params[:page], per_page: 4)
      flash.now[:success] = "Registration successful"
      render action: 'index'
    else 
      flash.now[:danger] = "Registration unsuccessful"
      render 'new'
    end


  end

  def new
    @student = Student.new
 end

  def show
    @student = Student.select("students.* , departments.name as dept_name").joins(:department).find(params[:id])
  end

  def edit
     @student = Student.find(params[:id])
  end

  
  private
    def student_params
      params.require(:student).permit(:first_name, :middle_name, :last_name, :address, :email, :state_id, :pincode, :emergency_no, :department_id, :country_id)
    end

end
