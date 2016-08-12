# Just wanted to make my database creation easily repeatbale
# so it's easy to fix inevitable spelling mistakes and omissions

require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'tiy_glossary.db'
)
ActiveRecord::Schema.define do
  create_table :terms do |column|
    column.string  :name
    column.string  :definition
    column.string  :author
    column.string  :web_link
    column.integer :category_id
  end

  create_table :categories do |column|
    column.string :name
    column.string :subject_area
  end
end
