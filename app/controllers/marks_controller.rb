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
    # debugger
    if flash_msg_elements.empty? then
      if params[:file].nil?
        flash_msg_elements.push('file')
      elsif params[:file].original_filename =~ /.*\.xlsx$/i  then
      		#process the imported file file
         
      		import_state = Mark.import(params[:file], params[:course][:id], params[:department][:id])
      		if  import_state == false then
      			flash.now[:error] = "File is not in the proper format"
      		elsif import_state.empty?
      			flash.now[:success] = "All records have been inserted/updated successfully"
      		else
      			flash.now[:warning] = "There was an error in the following rows: " + import_state.join(", ")
      		end
      		
      else
      		flash.now[:error] = "File type is not supported"
      end
    else
        flash.now[:error] = "Please ensure you select the following: " + flash_msg_elements.join(", ")
    end
    # alert = 'warning testted'    
  	# debugger
  	#redirect_to 'marks/index'
  	render 'index'
  end

  def generate_marksheet

  end

  def genpdf
    # @user = User.first
    # debugger
    respond_to do |format|
      format.html
      # debugger
      format.pdf do 
        # pdf = UserPdf.new(@user)
        pdf = MarksheetPdf.new
        # pdf.text "hello world"
        
        send_data pdf.render, filename: "test_file",
                            type: "application/pdf",
                            disposition: "inline"
        
        #  send_data pdf.render
      end

    end
  end


end
