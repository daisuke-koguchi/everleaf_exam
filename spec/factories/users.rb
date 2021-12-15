FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    email { "test@test.com" }
    password { "password" }
    admin {'false'}
  end
end
