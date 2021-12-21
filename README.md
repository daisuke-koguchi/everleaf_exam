# 構成モデル
### Userモデル  
| カラム名（日本語） | カラム名（英語） | データ型 | 
| ------------------ | ---------------- | -------- | 
| 名前               | name             | string   | 
| メール             | email            | string   | 
| パスワード         | password_digest  | string   | 
| 管理者             | admin            | boolean  | 
### Taskモデル  
| カラム名（日本語） | カラム名（英語） | データ型 | 
| ------------------ | ---------------- | -------- | 
| タスク名           | name             | string   | 
| タスク詳細         | description      | text     | 
| 終了期限           | deadline         | datetime | 
| 優先度             | priority         | integer  | 
| ステータス         | status           | integer  | 
### Labelモデル
| カラム名（日本語） | カラム名（英語） | データ型 | 
| ------------------ | ---------------- | -------- | 
| 名前               | name             | string   | 
### TaskモデルとLabelモデルの中間テーブル：LabelTask
| カラム名（日本語） | カラム名（英語） | データ型 | 
| ------------------ | ---------------- | -------- | 
| タスクID           | task_id          | bigint   | 
| ラベルID           | label_id         | bigint   | 


# Herokuへのデプロイ方法
1. アプリケーションのroot設定を行います。設定を行わないとHerokuデプロイ後にエラーが発生します。
```
root to: '〇〇〇#index' 
```
2. config/environments/puroduction.rbの下記コードをtrueに設定します。
```
config.assets.compile = false  #falseからtrueに変更
```
3. Railsアセットコンパイル実施します。
```
$ rails assets:precompile RAILS_ENV=production
```
4. Herokuにログインを実施た後にHerokuに新しいアプリケーションを作成します。
```
$ heroku login --interactive
$ heroku create
```
5. git add と git commit 実施します。
```
$ git add.
$ git commit -m "Herokuへデプロイする"
```
6. Heroku buildpack追加します。
```
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```
7. Herokuへデプロイ実施します。
```
$ git push heroku master　#masterブランチからherokuへデプロイする場合
$ git push heroku branch名:master　#branchからherokuへデプロイする場合
```
8. Herokuのデータベースマイグレーション実施
```
$ heroku run rails db:migrate
```
9. Herokuのアプリケーションを起動します。
```
$ heroku open #macのみ
```