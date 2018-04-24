PASSWORD = "password"

Post.destroy_all
Comment.destroy_all
User.destroy_all

super_user = User.create(
  first_name: "Jon",
  last_name: "Snow",
  email: "js@winterfell.gov",
  password: PASSWORD,
  is_admin: true 
)

10.times.each do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@hotmail.com",
    password: PASSWORD
  )
end

users = User.all
puts Cowsay.say "Created #{users.count} users", :stegosaurus

50.times do
  post = Post.create(
        title: Faker::LordOfTheRings.location, #only 35 locations oh well
        body: Faker::HitchhikersGuideToTheGalaxy.quote,
        user: users.sample
        )

  if post.valid?
    rand(0..10).times.each do
      Comment.create(
      body: Faker::Hobbit.quote,
      post: post,
      user: users.sample
      )
    end
  end
end

posts = Post.all
comments = Comment.all

puts Cowsay.say "Created #{posts.count} posts", :turkey
puts Cowsay.say "Created #{comments.count} comments", :turtle
puts "Log in with #{super_user.email} and password of '#{PASSWORD}'"
