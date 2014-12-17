require 'open-uri'
require 'nokogiri'
require "active_record"
require "activerecord-import/base"
require "yaml"
config = YAML.load_file('config/database.yml')

ActiveRecord::Base.establish_connection(config["development"])
ActiveRecord::Import.require_adapter('mysql2')

module IkeaCrawler
  class Crawler
    def initialize
      agent = YAML.load_file('config/useragent.yml')
      @user_agent = agent["default"]["name"]
      @page_source = nil
      @url_list = []
      
    end
    attr_reader :user_agent, :url_list

    def run(last_page=5)
      for i in 1..last_page
        url = "http://www.soundhouse.co.jp/search/index/?s_maker_cd=&s_category_cd=513&s_mid_category_cd=&s_large_category_cd=&s_product_cd=&search_all=&sSeriesCd=&sPriceFrom=0&sPriceTo=9999999&i_type=c&i_sub_type=&i_page=#{i}&i_sort=&i_page_size=30&i_ListType=type2"
        fetch url
        parse()
      end
    end

    def fetch(url)
      @page_source = open(url,"User-Agent" => user_agent)
    end

    def parse
      doc = Nokogiri::HTML.parse(@page_source, nil)
      doc.css("section#listcont").each do |elem|
        elem.css("div > p.photo > a").each do |o|
          @url_list.push("http://www.soundhouse.co.jp#{o[:href]}")
        end
      end
      persist()
      
    end
    
    private

    def persist
      pages = []
      @url_list.each do |page|
        pages << Productpage.new(detail: page)
      end
      Productpage.import pages
    end
    
  end
  class Productpage < ActiveRecord::Base
  end

end
