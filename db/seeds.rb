# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
=begin

30.times do |i| 
	# x = x + 1
	Student.create(regno: "aa_#{i}", first_name: "fname_#{i}", middle_name: "mname_#{i}", last_name: "lname_#{i}", email: "stud#{i}@email.com", address: 'test address #{i}', state_id: 3);
end
# x = 1
5.times do |i| 
	# x = x + 1
	Department.create(name: "Dept_#{i}"); 
end

Course.create(code: 'BB-11', name: 'Business Logic')
Course.create(code: 'BB-12', name: 'Understanding Business Concepts')
Course.create(code: 'BB-13', name: 'Religion 101')
Course.create(code: 'BB-14', name: 'New Testament')



State.create(name: 'Nagaland');
State.create(name: 'Manipur');
State.create(name: 'Arunachal');
State.create(name: 'Assam');
State.create(name: 'J & K');
State.create(name: 'Tripura');

=end
User.create(email: 'admin@demo.com', password: 'password')