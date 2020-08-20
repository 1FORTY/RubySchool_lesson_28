#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def init_db
  # Инициализируем в переменную БД и добавляем хэши
  @db = SQLite3::Database.new 'leprosorium.db'
  @results_as_hash = true

  return @db
end

before do
  # Добавляем БД во все запросы
  init_db
end

configure do
  # Создаём таблицу, если не созданан
  db = init_db
  db.execute 'CREATE TABLE IF NOT EXISTS "Posts" (
	  "id"	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	  "created_date"	DATE,
	  "content"	TEXT
  );'
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/new' do
  erb :new
end

post '/new' do
  @content = params[:content]

  erb "You typed: #{@content}"
end