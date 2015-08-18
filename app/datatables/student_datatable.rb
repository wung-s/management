# include AjaxDatatablesRails::Extensions::WillPaginate
# include AjaxDatatablesRails::Extensions::Kaminari
# include AjaxDatatablesRails::Extensions::SimplePaginator

class StudentDatatable < AjaxDatatablesRails::Base
  def_delegators :@view, :link_to, :student_path
  
  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= ['student.regno']
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= ['student.regno','student.first_name','student.email']
  end

  def view_columns
    @view_columns ||= ['student.regno','student.first_name','student.email']
  end

  private

      def data
        records.map do |record|
          [
            # comma separated list of the values for each cell of a table row
            # example: record.attribute,
            record.regno, 
            record.first_name, 
            record.email, 
            link_to("View Details", student_path(record.id))
          ]
        end
      end

      def get_raw_records
        Student.all
      end

      # ==== Insert 'presenter'-like methods below if necessary
      def query_result

      end
      
end
