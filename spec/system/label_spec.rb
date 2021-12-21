require 'rails_helper'
RSpec.describe 'ラベル検索機能', type: :system do
  def login
    user_a = FactoryBot.create(:user, email:'label@test.com')
    task_a = FactoryBot.create(:second_task, user: user_a )
    visit new_session_path 
    fill_in 'session[email]', with: 'label@test.com'
    fill_in 'session[password]', with: 'password'
    click_on 'commit'
    visit tasks_path 
  end

  def create 
      visit new_task_path
      fill_in 'task[name]', with: 'ラベルネーム'
      fill_in 'task[description]', with: 'ラベル詳細'
      find("#task_deadline_1i").find("option[value='2016']").select_option
      find("#task_deadline_2i").find("option[value='10']").select_option
      find("#task_deadline_3i").find("option[value='1']").select_option
      find("#task_status").find("option[value='完了']").select_option
      find("#task_priority").find("option[value='高']").select_option
      check '英語'
      click_on '登録'
  end

  before do
    login 
  end

  describe 'ラベル検索機能' do 
    let!(:task){FactoryBot.create(:task)}
    let!(:label){FactoryBot.create(:label, name:'英語')}
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
        check '英語'
        click_on '登録'
        expect(page).to have_content '英語'
      end
    end
    context 'タスク一覧画面でラベル検索した場合' do
      before do
        create 
      end
      it '検索したラベルを含むタスクで絞り込まれる' do
        visit tasks_path
        select'英語', from:'task[label_id]'
        click_on 'commit' 
        expect(page).to_not have_content 'テストタイトル2'
        expect(page).to have_content 'ラベルネーム' 
      end
    end

    context 'タスク編集画面でラベルを変更した場合' do 
      before do 
        create 
      end
      it '変更したラベルが一覧画面に表示される' do 
        FactoryBot.create(:label, name:'数学')
        FactoryBot.create(:second_label, name:'国語')
        visit tasks_path
        all('tbody tr')[0].click_on '編集'
        check '数学'
        check '国語'
        click_on '登録'
        expect(page).to have_selector 'td', text: '国語'
        expect(page).to have_selector 'td', text: '数学'
      end

    end
    context 'タスク一覧画面で削除ボタンを押した場合' do 
      before do 
        create 
      end
      it 'タスクと同時に登録されていたラベルも削除される' do 
        visit tasks_path
        sleep 0.5
        all('tbody tr')[0].click_on '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content('ラベル詳細')
        expect(page).not_to have_selector 'td', text: '英語'
        
      end
    end
  end
end