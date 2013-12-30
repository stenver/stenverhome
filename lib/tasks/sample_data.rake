namespace :db do
  desc "Fill database with sample data"
  task sample_populate: :environment do
    sample_populate_users
    sample_populate_articles
    sample_populate_comments
  end

  task sample_populate_users :environment do
    User.create!(name: "Stenver",
                 email: "Stenver1010@gmail.com",
                 password: "secret",
                 password_confirmation: "secret",
                 admin: true)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end

  task sample_populate_articles :environment do
    99.times do |n|
      title  = Faker::Name.name
      text = Faker::Lorem.paragraphs(paragraph_count = 5, supplemental = false).join('\n')
      user  = User.first
      Article.create!(title: title,
                      text: text,
                      user: user)
    end
  end

  task sample_populate_comments: :environment do
    99.times do |n|
      text = Faker::Lorem.paragraphs(paragraph_count = 1, supplemental = false).join('\n')
      user  = User.first
      article = Article.first
      Comment.create!(text: text,
                      user: user,
                      article: article)
    end
  end
end
