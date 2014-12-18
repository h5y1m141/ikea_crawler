require 'ikea_crawler'

crawler = IkeaCrawler::Crawler.new
# crawler.run
# crawler.show_subcategory_links

url = "http://www.ikea.com/jp/ja/catalog/categories/departments/bathroom/20719/"
crawler.fetch_product_page_links url

