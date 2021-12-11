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
    it '終了期限がないとバリデーションに引っかかる' do 
      task = Task.new(name:'失敗テスト', deadline:'')
      expect(task).not_to be_valid
    end
    it 'ステータスがないとバリデーションに引っかかる' do 
      task = Task.new(name:'失敗テスト',status:'')
      expect(task).not_to be_valid
    end
    it 'タスクのタイトル、詳細、終了期限、ステータスがあるとバリデーションが通過する' do
      task = Task.new(name:'成功タイトル名',description:'成功詳細',deadline:'2000-01-01',status:'完了')
      expect(task).to be_valid
    end
  end
  describe '検索機能' do
    context 'scopeメソッドであいまい検索をした場合'do
      it '検索キーワードを含むタスクが絞り込まれる'do
        task = Task.create(name:'テスト1',description:'詳細1',deadline:'2000-01-01',status:'未着手')
        second_task = Task.create(name:"テスト2",description:'詳細2',deadline:'2000-01-01',status:'完了')
        expect(Task.search_name('テスト1')).to include(task)
        expect(Task.search_name('テスト1')).not_to include(second_task)
        expect(Task.search_name('テスト1').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索した場合'do
      it 'ステータスに完全一致するタスクが絞り込まれる'do 
        task = Task.create(name:'テスト1',description:'詳細1',deadline:'2000-01-01',status:'未着手')
        second_task = Task.create(name:"テスト2",description:'詳細2',deadline:'2000-01-01',status:'完了')
        expect(Task.search_status('未着手')).to include(task)
        expect(Task.search_status('未着手')).not_to include(second_task)
        expect(Task.search_status('未着手').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる' do
        task = Task.create(name:'テスト1',description:'詳細1',deadline:'2000-01-01',status:'未着手')
        second_task = Task.create(name:"テスト2",description:'詳細2',deadline:'2000-01-01',status:'完了')
        expect(Task.search_name('テスト1')).to include(task)
        expect(Task.search_status('未着手')).to include(task)
        expect(Task.search_name('テスト1').count).to eq 1
      end
    end
  end
  
end