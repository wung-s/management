class MarksController < ApplicationController
  def edit
  end

  def index

  end

  def new
  end

  def show
  end

  def search
    @students = Student.where("regno like ?", "%#{params[:regno]}%")
    render 'index'
  end

  def import
    # debugger
    #if params[:file].original_filename =~ /.*\.xls|(xs)$/i  then
    # debugger
    flash_msg_elements = Array.new

    if params[:course][:id].blank?
      flash_msg_elements.push('Course')
    end
    if params[:department][:id].blank?
      flash_msg_elements.push('Department')
    end

    if flash_msg_elements.empty? then
      if params[:file].nil?
        flash_msg_elements.push('file')
      elsif params[:file].original_filename =~ /.*\.xlsx$/i  then
        #process the imported file file

        import_state = Mark.import(params[:file], params[:course][:id], params[:department][:id])
        if  import_state == false then
          flash[:error] = "File is not in the proper format"
        elsif import_state == 'no association'
          flash[:error] = "The selected department does not offer the selected course"
        elsif import_state.empty?
          flash[:success] = "All records have been inserted/updated successfully"
        else
          flash[:warning] = "There was an error in the following rows: " + import_state.join(", ")
        end

      else
        flash.now[:error] = "File type is not supported"
      end
    else
      flash.now[:error] = "Please ensure you select the following: " + flash_msg_elements.join(", ")
    end
    redirect_to action: :index
  end

  def generate_marksheet

  end

  def genpdf
    respond_to do |format|
      format.html
      format.pdf do 
        pdf = MarksheetPdf.new
        send_data pdf.render, filename: "test_file",
          type: "application/pdf",
          disposition: "inline"

        #  send_data pdf.render
      end
    end
  end
end
