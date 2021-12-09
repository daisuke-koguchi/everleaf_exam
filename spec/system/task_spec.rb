require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task){FactoryBot.create(:task)}
  let!(:second_task){FactoryBot.create(:second_task)}
  before do 
    visit tasks_path
  end
  describe '新規作成機能' do 
    context 'タスクを新規作成した場合' do 
      it '作成したタスクが表示される' do 
        visit new_task_path
        fill_in 'task[name]',with: 'テストname'
        fill_in 'task[description]',with: 'Rspecテスト'
        find("#task_deadline_1i").find("option[value='2016']").select_option
        find("#task_deadline_2i").find("option[value='10']").select_option
        find("#task_deadline_3i").find("option[value='1']").select_option
        click_on '登録'
        expect(page).to have_content '2016-10-01'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'テストタイトル1'
        expect(page).to have_content 'テストタイトル2'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_lists = all('#task_name')
        expect(task_lists[0]).to have_content 'テストタイトル2'
        expect(task_lists[1]).to have_content 'テストタイトル1'
      end
    end
    context '終了期限でソートするボタンを押した場合' do
      it '終了期限が新しいタスクが一番上に表示される' do
        visit tasks_path
        click_on '終了期限でソートする'
        expect(page).to have_content 'タスク一覧'
        deadline = all('#deadline')
        expect(deadline[0]).to have_content '2026-01-01'
        expect(deadline[1]).to have_content '2016-01-01'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do 
      it '該当タスクの内容が表示される'do 
        @task = FactoryBot.create(:task, name:'task',description:'task')
        visit task_path(@task.id)
        expect(page).to have_content 'task'
      end
    end
  end
end