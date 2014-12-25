require 'spec_helper'

describe IkeaCrawler::Page do
  before do
    permalinks = ['http://www.ikea.com/jp/ja/catalog/products/50283803/', 'http://www.ikea.com/jp/ja/catalog/products/40286388']
    @page = IkeaCrawler::Page.new(permalinks)
  end

  it 'should be able to setter ' do
    expect(@page.permalinks[0]).to eq 'http://www.ikea.com/jp/ja/catalog/products/50283803/'
  end


end
