namespace :insert_super_admin do
  desc "TODO"
  task insert: :environment do
  	User.create(:email => "superadmin@test.com",:name => "Super Admin",:role => "super admin",:password => "test123")
  end

end
