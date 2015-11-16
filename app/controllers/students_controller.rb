class StudentsController < ApplicationController

  def index
    @students = Student.paginate(page: params[:page])
    respond_to do |format|
          format.html
    end
  end

  def new
    @student = Student.new
  end

  def create

    @student = Student.new(student_params)
    @student.regno = @student.generate_regno(params[:student][:department_id])
    if @student.save
      @students = Student.paginate(page: params[:page])
      flash.now[:success] = "Registration successful"
      render action: 'index'
    else
      flash.now[:danger] = "Registration unsuccessful"
      render 'new'
    end
  end

  def edit
     @student = Student.find(params[:id])
     respond_to do |format|
        format.js
     end
  end

  def update
    @student = Student.find(params[:id])
    respond_to do |format|
      if @student.update(student_params)
        flash.now[:success] = "Update successful"
      else
        flash.now[:warning] = "Update unsuccessful"
      end

      format.html { redirect_to student_path}
      format.js

    end
  end

  def show
    @student = Student.select("students.* , departments.name as dept_name").joins(:department).find(params[:id])
  end

  def search
    @students = Student.joins("LEFT OUTER JOIN departments ON students.department_id = departments.id
                              LEFT OUTER JOIN marks ON students.id = marks.student_id")
                      .where("students.regno like ?", "%#{params[:regno]}%")
                      .paginate(page: params[:page])

   render 'index'
  end

  private
    def student_params
      params.require(:student).permit(:first_name, :middle_name, :last_name, :address, :email, :state_id, :pincode, :emergency_no, :department_id, :country_id)
    end

end
