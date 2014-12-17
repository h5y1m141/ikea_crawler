require 'ikea_crawler'

crawler = IkeaCrawler::Item.new

url = "http://www.ikea.com/jp/ja/catalog/products/50283803/"

crawler.fetch_item url

