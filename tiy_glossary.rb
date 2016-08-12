require 'active_record'
# require 'sinatra'
# require 'sinatra/reloader' if development?

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'tiy_glossary.db'
)

class Term < ActiveRecord::Base
  belongs_to :category
end

class Category < ActiveRecord::Base
  has_many :terms
end

# Category.create(name: "Testing2", subject_area: "Back End Engineering")
# Term.create(name: "Decepticon",
#             definition: "Malicious transforming robot and enemy of the AutoBots",
#             author: "Alan Kebert",
#             web_link: "www.testurl.com",
#             category_id: 2)
# Term.create(name: "AutoBot",
#             definition: "Benevolent transforming robot and enemy of the Decepticons",
#             author: "Alan Kebert",
#             web_link: "www.testurl.com",
#             category_id: 1)

terms = Term.all

terms.each do |term|
  puts "The term is #{term.name} and it means \"#{term.definition}\""
end
terms = Term.all.order(:name).reverse_order
p terms
terms = Term.where("definition like ?", "%robot%").take(2)
p terms
