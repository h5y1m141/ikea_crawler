require "active_record"
require "yaml"
config = YAML.load_file('config/database.yml')

ActiveRecord::Base.establish_connection(config["development"])
ActiveRecord::Migration.create_table :productpages do |t|
  t.string :product_image_url  
  t.integer :product_price
  t.text :description
  t.string :product_name
  t.string :product_permalink
  t.timestamps
  
end
