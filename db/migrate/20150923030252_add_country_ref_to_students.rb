class AddCountryRefToStudents < ActiveRecord::Migration
  def change
    add_reference :students, :country, index: true
    add_foreign_key :students, :countries
  end
end
