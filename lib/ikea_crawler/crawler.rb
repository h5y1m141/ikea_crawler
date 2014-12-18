# -*- coding: utf-8 -*-
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
      @subcategory_links = []
      
    end
    attr_reader :user_agent, :url_list

    def run
      main_category_links = [
         {name: 'ベッドルーム' , url: 'http://www.ikea.com/jp/ja/catalog/categories/departments/bathroom/'},
         {name: 'バスルーム' , url: 'http://www.ikea.com/jp/ja/catalog/categories/departments/bedroom/'},
         {name: 'テキスタイル',  url: 'http://www.ikea.com/jp/ja/catalog/categories/departments/Textiles/'},
         {name: 'キッズ' , url: 'http://www.ikea.com/jp/ja/catalog/categories/departments/childrens_ikea/'},
         {name: 'リビング' , url: 'http://www.ikea.com/jp/ja/catalog/categories/departments/living_room/'},
         {name: 'ダイニング' , url: 'http://www.ikea.com/jp/ja/catalog/categories/departments/dining/'},
         {name: 'キッチン' , url: 'http://www.ikea.com/jp/ja/catalog/categories/departments/kitchen/'},
         {name: 'ビジネス向け' , url: 'http://www.ikea.com/jp/ja/catalog/categories/business/'}



        ]
      for main_category in main_category_links
        fetch_subcategory_links(main_category[:url])
      end
    end

    def fetch_subcategory_links(main_category)
      @page_source = open(main_category,"User-Agent" => user_agent)
      doc = Nokogiri::HTML.parse(@page_source, nil)
      doc.css("#topNavigation").each do |elem|
        elem.css("div > ul > li > a").each do |o|
          @subcategory_links.push "http://www.ikea.com/#{o[:href]}"
        end
      end

    end

    def show_subcategory_links
      puts @subcategory_links
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
