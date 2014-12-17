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
  class Item
    def initialize
      agent = YAML.load_file('config/useragent.yml')
      @user_agent = agent["default"]["name"]
      @page_source = nil
      @url_list = []

    end
    attr_reader :user_agent, :url_list

    def fetch_item(url)
      @page_source = open(url,"User-Agent" => user_agent)
      parse()
    end
    
    def parse
      price = nil
      name = nil
      desc = nil
      image_url = nil

      doc = Nokogiri::HTML.parse(@page_source, nil)
      doc.css("#price1").each do |elem|
        price = elem.text().gsub(/^\s+/, "").gsub(/\¥/, "").gsub(/ /, "").gsub(/,/, "")
      end
      
      doc.css("#salesArg").each do |elem|
        # puts elem.text.strip.chomp
      end

      doc.css("#productImg").each do |elem|
        image_url = "http://www.ikea.com/#{elem[:src]}"
      end
      puts "金額：#{price}"
      puts "写真のURL：#{image_url}"
      # puts "商品名：#{price}"
      # puts "説明文：#{price}"


      # persist()
      
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
end
