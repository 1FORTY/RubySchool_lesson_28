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
  # Выбираем список постов из DB
  @results = @db.execute 'select * from Posts order by id desc'

	erb :index
end

get '/new' do
  erb :new
end

post '/new' do
  @content = params[:content]

  if @content.length <= 1
    @error = 'Type post text'
    return erb :new
  end

  # Сохранение данных
  @db.execute 'insert into Posts (created_date, content) values (datetime(), ?)', [@content]

  erb :index
end