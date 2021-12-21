FactoryBot.define do
  factory :label_task do
      association :label 
      association :task
  end
end
