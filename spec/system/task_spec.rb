require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do 
    context 'タスクを新規作成した場合' do 
      it '作成したタスクが表示される' do 
        visit new_task_path
        fill_in 'task[name]',with: 'テストname'
        fill_in 'task[description]',with: 'Rspecテスト'
        click_button '登録'
        expect(page).to have_content 'テストname'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, name: 'task') 
        visit tasks_path
        expect(page).not_to have_content 'task'
      end
    end
  end
end
