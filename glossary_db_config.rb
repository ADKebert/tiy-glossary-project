# Just wanted to make my database creation easily repeatbale
# so it's easy to fix inevitable spelling mistakes and omissions

require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'tiy_glossary.db'
)
ActiveRecord::Schema.define do
  unless table_exists?(:terms)
    create_table :terms do |column|
      column.string   :name
      column.string   :definition
      column.string   :author
      column.integer  :category_id
      column.datetime :created_at
      column.datetime :updated_at
    end
  end

  unless table_exists?(:categories)
    create_table :categories do |column|
      column.string   :name
      column.string   :subject_area
      column.datetime :created_at
      column.datetime :updated_at
    end
  end

  unless table_exists?(:comments)
    create_table :comments do |column|
      column.integer  :term_id
      column.datetime :created_at
      column.string   :body
      column.string   :author
    end
  end

  unless table_exists?(:web_links)
    create_table :web_links do |column|
      column.string   :description
      column.string   :url
      column.integer  :term_id
    end
  end
end
