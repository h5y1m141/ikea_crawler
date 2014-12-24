require 'ikea_crawler'

crawler = IkeaCrawler::Crawler.new
crawler.run

crawler.subcategory_links.each do |page|
  crawler.fetch_product_page_links page
  sleep 3
end

