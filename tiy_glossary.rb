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
  @recent_terms = Term.order(created_at: :desc).take(5)
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
  Term.create params["term"]

  redirect '/terms'
end

get '/terms/new' do
  # display a term creation form
  @categories = Category.all.order(:name)
  haml :terms_new
end

get '/terms/:id/edit' do
  # display term edit form
  @categories = Category.all.order(:name)
  @term = Term.find(params[:id])
  haml :terms_edit
end

get '/terms/:id' do
  # display one term's information
  @term = Term.find(params[:id])
  haml :terms_show
end

put '/terms/:id' do
  # update one term
  term = Term.find(params[:id])
  term.update_attributes(params["term"])

  redirect "/terms/#{params[:id]}"
end

delete '/terms/:id' do
  # delete a term
  Term.find(params[:id]).destroy
  redirect '/terms'
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
  Category.create(params["category"])

  redirect '/categories'
end

get '/categories/new' do
  # display a category creation from
  haml :categories_new
end

get '/categories/:id' do
  # display a single category's information
  @category = Category.find(params[:id])
  haml :categories_show
end
