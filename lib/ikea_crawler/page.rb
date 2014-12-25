# -*- coding: utf-8 -*-
require "active_record"
require "activerecord-import/base"
require "yaml"
config = YAML.load_file('config/database.yml')
ActiveRecord::Base.establish_connection(config["development"])
ActiveRecord::Import.require_adapter('mysql2')



module IkeaCrawler
  class Pages
    def initialize(permalinks)
      @permalinks = permalinks
    end
    
    attr_accessor :permalinks

    def persist
      pages = []
      @permalinks.each do |page|
        pages << Page.new(permalink: page)
      end
      Page.import pages
      return true
    end
    
  end
  class Page < ActiveRecord::Base
  end

end
