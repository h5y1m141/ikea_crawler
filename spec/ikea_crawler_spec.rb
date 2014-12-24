require 'spec_helper'

describe IkeaCrawler do
  before do
    @crawler = IkeaCrawler::Crawler.new
    @crawler.run
  end

  it 'has a version number' do
    expect(IkeaCrawler::VERSION).not_to be nil
  end

  it 'should be return  subcategory links' do
    expect(@crawler.subcategory_links.length).to be >  1
  end
end
