class CreateCourseAssociations < ActiveRecord::Migration
  def change
    create_table :course_associations do |t|

      t.timestamps null: false
    end
  end
end
