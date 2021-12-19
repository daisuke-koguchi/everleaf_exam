# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
  name: 'テスト一郎',
  email: 'test@test.com',
  password: 'password',
  password_confirmation: 'password',
  admin: false 
)

User.create!(
  name: '管理者',
  email: 'admin@test.com',
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