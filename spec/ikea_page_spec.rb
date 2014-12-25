require 'spec_helper'

describe IkeaCrawler::Page do
  before do
    permalinks = ['http://www.ikea.com/jp/ja/catalog/products/50283803/', 'http://www.ikea.com/jp/ja/catalog/products/40286388']
    @pages = IkeaCrawler::Pages.new(permalinks)
  end

  it 'should be able to setter ' do
    expect(@pages.permalinks[0]).to eq 'http://www.ikea.com/jp/ja/catalog/products/50283803/'
  end

  it 'should define persist Class method' do
    expect(IkeaCrawler::Pages.method_defined?(:persist)).to be true
  end

  it 'should be valid' do
    expect(@pages.respond_to?(:persist)).to be true
  end


  it 'should be import permalinks into database' do
    expect(@pages.persist()).to be true
  end


end
