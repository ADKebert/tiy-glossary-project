require 'active_record'
require 'sinatra'
require 'sinatra/content_for'
require 'sinatra/reloader' if development?

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'tiy_glossary.db'
)

ActiveRecord::Base.logger = Logger.new(STDOUT)

Rack::MethodOverride

class Term < ActiveRecord::Base
  belongs_to :category
end

class Category < ActiveRecord::Base
  has_many :terms
end

after do
  ActiveRecord::Base.connection.close
end

# -------------HOMEPAGE--------------
get '/' do
  # list of 5 recent terms
  @recent_terms = Term.order(id: :desc).take(5)
  # link to terms index
  # link to categories index
  haml :home
end

# --------------TERM------------------
get '/terms' do
  # alphabetical list of all terms
  @terms = Term.all.order(:name)
  # add a term
  # search a term
  haml :terms_index
end

post '/terms' do
  # add a new term to the database
end

get '/terms/new' do
  # display a term creation form
end

get '/terms/:id/edit' do
  # display term edit form
end

get '/terms/:id' do
  # display one term's information
end

put '/terms/:id' do
  # update one term
end

delete '/terms/:id' do
  # delete a term
end

# --------------CATEGORY----------------
get '/categories' do
  # alphabetical list of all categories
  @categories = Category.all.order(:name)
  # add a category
  haml :categories_index
end

post '/categories' do
  # add a new category to the database
end

get '/categories/new' do
  # display a category creation from
end

get '/categories/:id' do
  # display a single category's information
end
