require 'rails_helper'
RSpec.describe 'ラベル検索機能', type: :system do
  def login
    user_a = FactoryBot.create(:user, email:'label@test.com')
    visit new_session_path 
    fill_in 'session[email]', with: 'label@test.com'
    fill_in 'session[password]', with: 'password'
    click_on 'commit'
    visit tasks_path 
  end

  # def create 
  #     visit new_task_path
  #     fill_in 'task[name]', with: 'ラベルネーム'
  #     fill_in 'task[description]', with: 'ラベル詳細'
  #     find("#task_deadline_1i").find("option[value='2016']").select_option
  #     find("#task_deadline_2i").find("option[value='10']").select_option
  #     find("#task_deadline_3i").find("option[value='1']").select_option
  #     find("#task_status").find("option[value='完了']").select_option
  #     find("#task_priority").find("option[value='高']").select_option
  #     check 'テストラベル'
  #     click_on '登録'
  # end
  describe 'ラベル検索機能' do 
    let!(:task){FactoryBot.create(:task)}
    let!(:label){FactoryBot.create(:label)}
    before do 
      login
    end
    context 'タスク新規作成画面でラベルを選択してタスクを作成した場合' do
      it '選択したラベルを含むタスクが表示される' do
        visit new_task_path
        fill_in 'task[name]', with: 'ラベルネーム'
        fill_in 'task[description]', with: 'ラベル詳細'
        find("#task_deadline_1i").find("option[value='2016']").select_option
        find("#task_deadline_2i").find("option[value='10']").select_option
        find("#task_deadline_3i").find("option[value='1']").select_option
        find("#task_status").find("option[value='完了']").select_option
        find("#task_priority").find("option[value='高']").select_option
        check 'テストラベル'
        click_on '登録'
        expect(page).to_not have_content 'テストラベル'
      end
    end
    context 'タスク一覧画面でラベル検索した場合' do 
      it '検索したラベルを含むタスクで絞り込まれる' 
      pending
    end
    context 'タスク編集画面でラベルを変更した場合' do 
      it '変更したラベルが一覧画面に表示される' do 
        pending
      end
    end
    context 'タスク一覧画面で削除ボタンを押した場合' do 
      it 'タスクと同時に登録されていたラベルも削除される' do 
        pending
      end
    end
  end
end