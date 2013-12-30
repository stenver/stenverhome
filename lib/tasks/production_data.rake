namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Stenver",
                 email: "Stenver1010@gmail.com",
                 password: "secret",
                 password_confirmation: "secret",
                 admin: true)
  end
end
