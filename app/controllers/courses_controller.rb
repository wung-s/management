class CoursesController < ApplicationController
  def index
    # debugger
  	@course = Course.new
    @course.course_associations.new
    @courses = Course.joins('LEFT OUTER JOIN course_associations ON course_associations.course_id = courses.id LEFT OUTER JOIN departments ON course_associations.department_id = departments.id ').select('courses.id, courses.code, courses.name, departments.name as dept_name, course_associations.id as course_association_id, course_associations.semester as semester, course_associations.credit_hour as credit_hour')
  	# @courses = Course.all
  	 # debugger
  end

  def search
    @course = Course.new
    @course.course_associations.new
  	@courses = Course.joins('LEFT OUTER JOIN course_associations ON course_associations.course_id = courses.id LEFT OUTER JOIN departments ON course_associations.department_id = departments.id ').select('courses.code, courses.name, departments.name as dept_name').where("courses.code like ?", "%#{params[:code]}%")
  	# debugger
  	render 'index'
  end

  def edit
    @course = Course.includes(:departments, :course_associations).find(params[:id])
    # @course.course_associations.build
    
  end

  def update
    
    @course = Course.find(params[:id])
    
    if @course.update(course_params)
      # debugger
      flash.now[:success] = "Update successful"
      redirect_to courses_path
    else 
      # debugger
      flash.now[:warning] = "Update unsuccessful"
      redirect_to 'edit'  
    end  
  end


  def show
  end

  def create
    @course = Course.new(course_params)
    respond_to do |format|
      if @course.save
        @course = Course.new
        format.html {redirect_to "index",  success: "Course added successfully" }
        format.js   
      end

    end
    

  end


  private

    def course_params
      params.require(:course).permit(:code, :name, course_associations_attributes: [:id, :department_id, :credit_hour, :semester])
      # params.require(:course).permit(:code, :name, course_associations_attributes: [ :department_id, :credit_hour, :semester])
    end

end
