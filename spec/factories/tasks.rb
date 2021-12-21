FactoryBot.define do
  factory :task ,class: Task do
      name {'テストタイトル1'}
      description {'テスト詳細1'}
      deadline{'2026-01-01'}
      status{'未着手'}
      priority{'高'}
  end
  factory :second_task ,class: Task do
      name {'テストタイトル2'}
      description {'テスト詳細2'}
      deadline {'2016-01-01'}
      status{'完了'}
      priority{'低'}
  end
end
