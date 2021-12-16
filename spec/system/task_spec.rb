require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe 'ユーザー登録機能'do 
    context 'ユーザー登録した場合'do
      it '作成したユーザーが詳細画面に表示される' do
        visit new_user_path
        fill_in 'user[name]',	with: 'テストユーザー'
        fill_in 'user[email]', with: 'task@test.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_on 'commit'
        expect(page).to have_content 'テストユーザー'
      end
    end
    context 'ユーザー登録せずにタスク一覧画面に移動しようとした場合'do
      it 'ログイン画面に戻される'do 
      visit tasks_path
      expect(page).to have_content 'ログイン画面'
      end
    end
  end
  describe 'セッション機能' do 
    let(:user_a){FactoryBot.create(:user, name:'ユーザーA',email: 'a@test.com',id:1)}
    before do 
        visit new_session_path 
        fill_in 'session[email]', with: 'a@test.com'
        fill_in 'session[password]', with: 'password'
        click_on 'commit'
    end
    context 'ログインした場合'do
      it 'ログインに成功すること' do
        user_b = FactoryBot.create(:user,name:'ユーザーB',email:'b@test.com')
        visit new_session_path 
        fill_in 'session[email]', with: 'b@test.com'
        fill_in 'session[password]', with: 'password'
        click_on 'commit'
        expect(current_path).to eq user_path(user_b)
        end
      end
    context 'ログインした場合'do 
      it '自分の詳細画面にアクセスできる' do 
        user_b = FactoryBot.create(:user,name:'ユーザーB',email:'b@test.com')
        visit new_session_path 
        fill_in 'session[email]', with: 'b@test.com'
        fill_in 'session[password]', with: 'password'
        click_on 'commit'
        expect(page).to have_content 'ユーザーB'
      end
    end
    context '一般ユーザー他人の詳細ページにアクセスする' do
      it 'タスク一覧画面に遷移する' do 
        user_b = FactoryBot.create(:user,name:'Bユーザー',email: 'b@test.com')
        visit new_session_path 
        fill_in 'session[email]', with: 'b@test.com'
        fill_in 'session[password]', with: 'password'
        click_on 'commit'
        visit user_path(user_a)
        expect(page).to have_content 'タスク一覧'
      end
    end
    context 'ログイン時にログアウトボタンを押すと' do 
      it 'ログアウトできること' do 
        user_b = FactoryBot.create(:user,name:'ユーザーB',email:'b@test.com')
        visit new_session_path 
        fill_in 'session[email]', with: 'b@test.com'
        fill_in 'session[password]', with: 'password'
        click_on 'commit'
        click_on 'ログアウト'
        expect(page).to have_content 'ログイン画面'
      end
    end
  end
  describe '管理画面' do 
    let!(:admin){FactoryBot.create(:user, name:'管理ユーザー',email: 'admin@test.com', admin:'true' )}
  
    before do 
      visit new_session_path 
      fill_in 'session[email]', with: 'admin@test.com'
      fill_in 'session[password]', with: 'password'
      click_on 'commit'
    end

    context '管理ユーザーが管理者画面へボタンを押すと' do 
      it '管理画面（登録ユーザー一覧）にアクセス出来る' do
        click_on '管理者画面へ'
        expect(page).to have_content '登録ユーザー一覧'
      end
    end
    context '一般ユーザーが管理画面にアクセスすると'do 
      it '管理画面にアクセス出来ない' do 
        FactoryBot.create(:user, name:'一般ユーザー', email:'not_admin@test.com')
        visit new_session_path 
        fill_in 'session[email]', with: 'not_admin@test.com'
        fill_in 'session[password]', with: 'password'
        click_on 'commit'
        expect(page).to_not have_button '管理者画面へ'
      end
    end
    context '管理ユーザが新規登録すると' do 
      it '新規ユーザーが登録出来る' do
        visit new_admin_user_path 
        fill_in 'user[name]', with: 'テスト太郎'
        fill_in 'user[email]', with: 'taro@test.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        check 'user[admin]'
        click_on 'サインアップ'
        expect(page).to have_content 'テスト太郎'
      end
    end
    context '管理ユーザが詳細画面のリンクボタンを押すと' do 
      it '登録ユーザーの詳細画面にアクセス出来る' do 
        user_c = FactoryBot.create(:user, name:'一般ユーザー',email:'c@test.com')
        visit admin_user_path(user_c)
        expect(page).to have_content '一般ユーザー'
      end
    end
    context '管理ユーザーがユーザーの削除ボタンを押すと' do 
      it 'ユーザーの削除を行える' do
        user_d = FactoryBot.create(:user, name:'一般ユーザー',email:'d@test.com')
        visit admin_users_path 
        all('tbody tr')[1].click_on '削除'
        sleep 0.5
        expect(page).not_to have_content('一般ユーザー')
      end
    end
  end
  describe '新規作成機能' do 
    let!(:user){FactoryBot.create(:user,email: 'new@test.com')}
    let!(:task){FactoryBot.create(:task,user: user)}
    let!(:task){FactoryBot.create(:second_task,user: user)}
    before do 
      visit new_session_path 
      fill_in 'session[email]', with: 'new@test.com'
      fill_in 'session[password]', with: 'password'
      click_on 'commit'
      visit tasks_path 
    end
    context 'タスクを新規作成した場合' do 
      it '作成したタスクが表示される' do 
        visit new_task_path
        fill_in 'task[name]',with: 'テストname'
        fill_in 'task[description]',with: 'Rspecテスト'
        find("#task_deadline_1i").find("option[value='2016']").select_option
        find("#task_deadline_2i").find("option[value='10']").select_option
        find("#task_deadline_3i").find("option[value='1']").select_option
        find("#task_status").find("option[value='完了']").select_option
        find("#task_priority").find("option[value='高']").select_option
        click_on '登録'
        expect(page).to have_content '2016-10-01'
        expect(page).to have_content '完了'
        expect(page).to have_content '高'
      end
    end
  end
  describe '一覧表示機能' do
    let!(:user){FactoryBot.create(:user, name:'タスク',email:'task@test.com',password:'password')}

    before do 
      FactoryBot.create(:task, user: user)
      FactoryBot.create(:second_task, user: user)
      visit new_session_path 
      fill_in 'session[email]', with: 'task@test.com'
      fill_in 'session[password]', with: 'password'
      click_on 'commit' 
      visit tasks_path
    end

    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
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
    context '優先順位でソートするボタンを押した場合' do 
      it '優先順位が高いタスクが一番上に表示される'do
        visit tasks_path
        click_on '優先順位でソートする'
        sleep 0.5
        priority = all('#priority')
        expect(priority[0]).to have_content '高'
        expect(priority[1]).to have_content '低'
      end
    end
  end
  describe '詳細表示機能' do
    let!(:user_a){FactoryBot.create(:user, name:'タスクユーザー',email:'task@test.com',password:'password')}
    let!(:task_a){FactoryBot.create(:task, name:'タスク1',user: user_a)}
    before do 
      visit new_session_path 
      fill_in 'session[email]', with: 'task@test.com'
      fill_in 'session[password]', with: 'password'
      click_on 'commit' 
      visit tasks_path
    end

    context '任意のタスク詳細画面に遷移した場合' do 
      it '該当タスクの内容が表示される'do 
        visit task_path(task_a)
        expect(page).to have_content 'タスク1'
      end
    end
  end
  describe '検索機能'do
  let!(:user_a){FactoryBot.create(:user, name:'タスクユーザー',email:'task@test.com',password:'password')}
  let!(:task_a){FactoryBot.create(:task, user: user_a)}
  let!(:task_b){FactoryBot.create(:second_task, user: user_a)}
    before do 
      visit new_session_path 
      fill_in 'session[email]', with: 'task@test.com'
      fill_in 'session[password]', with: 'password'
      click_on 'commit' 
      visit tasks_path
    end
    context 'タイトルであいまい検索をした場合' do
      it '検索キーワードを含むタスクで絞り込まれる' do 
        visit tasks_path
        fill_in 'task[name]',with: 'テストタイトル1'
        select '未着手', from: 'task[status]'
        click_on '検索'
        expect(page).to have_content 'テストタイトル1'
      end
    end
    context'ステータスを検索した場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる'do 
        visit tasks_path
        select '未着手', from: 'task[status]'
        click_on '検索'
        expect(page).to have_content '未着手'
      end
    end
    context'scoopメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it '検索キーワードにタイトルを含み、かつステータスに一致するタスクに絞り込まれる'do
        visit tasks_path
        fill_in 'task[name]',with:'テストタイトル2'
        select '完了',from: 'task[status]'
        click_on '検索'
        expect(page).to have_content 'テストタイトル'
        expect(page).to have_content '完了'
      end
    end
  end
end