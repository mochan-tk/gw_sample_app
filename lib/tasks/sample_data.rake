namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    # create!とは、失敗した時（例外）が発生したら即時で処理がとまる
    User.create!(name: "Example User",
                 email: "example@railstutorial.jp",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    99.times do |n|
      name  = Faker::Name.name # Faker使うと、それっぽい名前のユーザができる、便利
      email = "example-#{n+1}@railstutorial.jp"
      password  = "password"
      # create!とは、失敗した時（例外）が発生したら即時で処理がとまる（ここは９９回まわすだけだが、１万回とかの時に効力を発揮すると思われる
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end