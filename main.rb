require 'ikea_crawler'

crawler = IkeaCrawler::Crawler.new
crawler.run
crawler.show_subcategory_links

