puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :name => 'Matt Preston', :email => 'matt.james.preston@googlemail.com', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << user.name
