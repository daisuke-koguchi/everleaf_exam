# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
  name: 'テスト一郎',
  email: 'test_user@test.com',
  password: 'password',
  password_confirmation: 'password',
  admin: false 
)

User.create!(
  name: '管理者',
  email: 'admin_user@test.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true  
)

Label.create!(
  name:'英語'
)
Label.create!(
  name:'数学'
)
Label.create!(
  name:'国語'
)
Label.create!(
  name:'社会'
)
Label.create!(
  name:'理科'
)

10.times do |i|
  User.create(
    name: "user#{n+1}",
    email: "user#{n+1}@example.com",
    password: 'password',
    password_confirmation: 'password',
    admin: false 
  )
end

10.times do |i|
  Task.create(
    name: "task#{n+1}",
    description: "description#{n+1}",
    deadline: DateTime.now,
    status: 0,
    priority: 0,
    user_id: 1
  )
end

10.times do |i|
  LabelTask.create(
    label_id: i + 1, 
    task_id: 1
  )
end

10.times do |i|
  Label.create(
    name:"label#{n+1}"
  )
end