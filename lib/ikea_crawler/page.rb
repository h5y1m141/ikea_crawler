# -*- coding: utf-8 -*-
require "active_record"
require "activerecord-import/base"
require "yaml"
config = YAML.load_file('config/database.yml')

ActiveRecord::Base.establish_connection(config["development"])
ActiveRecord::Import.require_adapter('mysql2')

module IkeaCrawler
  class Page
    def initialize(permalinks)
      @permalinks = permalinks
    end
    attr_accessor :permalinks

    
  end
end
