class CreateGradePoints < ActiveRecord::Migration
  def change
    create_table :grade_points do |t|

      t.timestamps null: false
    end
  end
end
