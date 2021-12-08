FactoryBot.define do
  factory :task do
      name {'テストタイトル1'}
      description {'テスト詳細1'}
  end
  factory :second_task, class: Task do
      name {'テストタイトル2'}
      description {'テスト詳細2'}
  end
end
