class CoursesController < ApplicationController
  before_action :set_course, only: [:index, :search]
  before_action :find_all_course, only: [:index, :create]

  def index

  end

  def new
    @course = Course.new
  end

  def create

    @course = Course.new(course_params)
    respond_to do |format|
      if @course.save
        format.js
      end

    end
  end

  def edit
      @course = Course.includes(:departments, :course_associations).find(params[:id])

  end

  def update
    @course = Course.find(params[:id])
    respond_to do |format|
      if @course.update(course_params)
        #flash.now[:success] = "Update successful"
        #redirect_to courses_path
        format.html { redirect_to courses_path}
        format.js
      else
        flash.now[:warning] = "Update unsuccessful"
      redirect_to 'edit'
    end
    end

  end

  def search
    @courses = Course.joins('LEFT OUTER JOIN course_associations ON course_associations.course_id = courses.id
                             LEFT OUTER JOIN departments ON course_associations.department_id = departments.id ')
                     .select('courses.id,
                              courses.code,
                              courses.name,
                              departments.name as dept_name,
                              course_associations.id as course_association_id,
                              course_associations.semester as semester,
                              course_associations.credit_hour as credit_hour')
                     .where("courses.code like ?", "%#{params[:code]}%")
                     .paginate(page: params[:page])

    render 'index'
  end

  def show
  end

  private

    def course_params
      params.require(:course).permit(:code, :name, course_associations_attributes: [:id, :department_id, :credit_hour, :semester])

    end

    def set_course
      @course = Course.new
      @course.course_associations.new
    end

    def find_all_course

      @courses = Course.joins('LEFT OUTER JOIN course_associations ON course_associations.course_id = courses.id
                               LEFT OUTER JOIN departments ON course_associations.department_id = departments.id ')
                       .select('courses.id,
                                courses.code,
                                courses.name,
                                departments.name as dept_name,
                                course_associations.id as course_association_id,
                                course_associations.semester as semester,
                                course_associations.credit_hour as credit_hour')
                       .order(id: :desc)
                       .paginate(page: params[:page])


    end

end
