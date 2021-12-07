require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe 'validation' do
    it 'タスク名がなないとバリデーションに引っかかる'do
      task = Task.new(name:'', description:'失敗テスト')
      expect(task).not_to be_valid
    end
    it '詳細がないとバリデーションに引っかかる' do
      task = Task.new(name:'失敗テスト', description:'')
      expect(task).not_to be_valid
    end
    it 'タスクのタイトルと詳細があるとバリデーションが通過する' do
      task = Task.new(name:'成功タイトル名',description:'成功詳細')
      expect(task).to be_valid
    end
  end
end