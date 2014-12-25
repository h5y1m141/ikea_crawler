require "active_record"
require "yaml"
config = YAML.load_file('config/database.yml')

ActiveRecord::Base.establish_connection(config["development"])
ActiveRecord::Migration.create_table :pages do |t|
  t.string :permalink
  t.timestamps
  
end
