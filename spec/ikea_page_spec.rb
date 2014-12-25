require 'spec_helper'

describe IkeaCrawler::Page do
  before do
    permalinks = ['http://www.ikea.com/jp/ja/catalog/products/50283803/', 'http://www.ikea.com/jp/ja/catalog/products/40286388']
    @page = IkeaCrawler::Page.new(permalinks)
  end

  it 'should be able to setter ' do
    expect(@page.permalinks[0]).to eq 'http://www.ikea.com/jp/ja/catalog/products/50283803/'
  end

  it 'should define persist Class method' do
    expect(IkeaCrawler::Page.method_defined?(:persist)).to be true
  end

  it 'should be valid' do
    expect(@page.respond_to?(:persist)).to be true
  end


end
