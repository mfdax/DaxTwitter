10.times do
  user = User.create username: Faker::Internet.user_name,
                     password: "password",
                     password_confirmation: "password"
end

10.times do
  user = User.all.sample
  created_at = [*1..30].sample.days.ago
  Tweet.create user: user,
               content: Faker::Hacker.say_something_smart,
               created_at: created_at,
               updated_at: created_at
end
