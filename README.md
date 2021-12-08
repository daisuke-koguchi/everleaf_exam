# 構成モデル
### Userモデル  
| カラム名（日本語） | カラム名（英語） | データ型 | 
| ------------------ | ---------------- | -------- | 
| 名前               | name             | string   | 
| メール             | email            | string   | 
| パスワード         | password         | string   | 
### Taskモデル  
| カラム名（日本語） | カラム名（英語） | データ型 | 
| ------------------ | ---------------- | -------- | 
| タスク名               | name            | string   | 
| タスク詳細               | description           | text     | 
| ステータス         | status           | string   | 
| 優先度             | priority         | integer  | 
### Labelモデル
| カラム名（日本語） | カラム名（英語） | データ型 | 
| ------------------ | ---------------- | -------- | 
| 名前               | name             |          | 


# Herokuへのデプロイ方法
1. アプリケーションのroot設定を行う
```
root to: '〇〇〇#index' #設定しないとエラーが発生
```
2. config/environments/puroduction.rbの下記コードをtrueに設定
```
config.assets.compile = true  #falseからtrueに変更
```
3. Railsアセットコンパイル実施
```
$ rails assets:precompile RAILS_ENV=production
```
4. Herokuにログインを実施。Herokuに新しいアプリケーションを作成。
```
$ heroku login --interactive
$ heroku create
```
5. git add と git commit 実施
```
$ git add.
$ git commit -m "Herokuへデプロイする"
```
6. Heroku buildpack追加
```
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```
7. Herokuへデプロイ実施
```
$ git push heroku master　#masterブランチからherokuへデプロイする場合
$ git push heroku branch名:master　#branchからherokuへデプロイする場合
```
8. Herokuのデータベースマイグレーション実施
```
$ heroku run rails db:migrate
```
9. Herokuのアプリケーションを起動
```
$ heroku open #macのみ
```