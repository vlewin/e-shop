user=User.new(:email => "customer@mail.com", :password => "password", :name => "Customer")
user.skip_confirmation!
user.save

user=User.new(:email => "admin@mail.com", :password => "password", :name => "Admin")
user.skip_confirmation!
user.save
user.admin!