require 'spec_helper'
require 'analyzer/page'
# analizer/page.rb
RSpec.describe SiteAnalyzer::Page do
  subject(:page) { SiteAnalyzer::Page.new initial_values }
  let(:initial_values) { 'http://savchuk.space' }
  array1 = ["http://myjewelryshop.ru/", "#", "#logoModal", "https://www.facebook.com/denis.savchuk.3", "https://ru.linkedin.com/pub/denis-savchuk/31/944/443", "skype:realmordor?add", "https://vk.com/darkmordor", "mailto:denis@savchuk.space", "#myCarousel"]
  array2 = ["Denis Savchuk Professional Web Developer", {"http://savchuk.space"=>""}, {"http://savchuk.space"=>""}]
  describe '#title_good?' do
    it 'check that title txt less then 70 symbols' do
      expect(page.title_good?).to eq true
    end
  end
  describe '#title_and_h1_good?' do
    context 'is false' do
      let(:initial_values) { 'http://savchuk.space' }
      it 'when have only title' do
        expect(page.title_and_h1_good?).to eq true
      end
    end
    context 'is true' do
      let(:initial_values) { 'http://google.com' }
      it 'when have one title without same text in it' do
        expect(page.title_and_h1_good?).to eq true
      end
    end
  end
  describe '#metadescription_good?' do
    context 'is false' do
      let(:initial_values) { 'http://savchuk.space' }
      it 'when dont have meta tag' do
        expect(page.metadescription_good?).to eq false
      end
    end
    context 'is true' do
      let(:initial_values) { 'https://mail.ru' }
      it 'when have meta tag and tag less then 200 sym' do
        expect(page.metadescription_good?).to eq true
      end
    end
  end
  describe '#keywords_good?' do
    context 'is false' do
      let(:initial_values) { 'http://savchuk.space' }
      it 'when dont have keywords tag' do
        expect(page.keywords_good?).to eq false
      end
    end
    context 'is true' do
      let(:initial_values) { 'https://mail.ru' }
      it 'when value in tag less then 600' do
        expect(page.keywords_good?).to eq true
      end
    end
  end
  describe '#code_less?' do
    context 'is false and bad' do
      let(:initial_values) { 'http://yandex.ru' }
      it 'when script tag code more then half of symbols on page' do
        expect(page.code_less?).to eq false
      end
    end
    context 'is good and true' do
      let(:initial_values) { 'http://savchuk.space' }
      it 'when code less than half' do
        expect(page.code_less?).to eq true
      end
    end
  end
  describe '#metadates_good?' do
    context 'is true' do
      let(:initial_values) { 'https://mail.ru' }
      it 'when title only one' do
        expect(page.metadates_good?).to eq true
      end
    end
    context 'is bad and false' do
      it 'when dont have meta tags test check true' do
        expect(page.metadates_good?).to eq true
      end
    end
  end
  describe '#all_titles_h1_h2' do
    context 'when all fine' do
      let(:initial_values) { 'http://savchuk.space' }
      it 'return array of all titles, h1 and h2 on page' do
        expect(page.all_titles_h1_h2).to eq array2
      end
    end
  end
  describe '#home_a' do
    context 'when have links on site' do
      let(:initial_values) { 'http://savchuk.space' }
      it 'return array of all a tags that went only on this site' do
        expect(page.home_a.uniq).to eq ['mailto:denis@savchuk.space']
      end
    end
  end
  describe '#all_a_tags_href' do
    it 'return href from all a tag on page' do
      expect(page.all_a_tags_href.uniq).to eq array1
    end
  end
  describe '#wrong_a' do
    it 'find wrong a with /?meta= and return array' do
      expect(page.wrong_a).to eq []
    end
  end
  describe '#h2?' do
    let(:initial_values) { 'http://yandex.ru' }
    it 'check that page have h2 tag and return true if have' do
      expect(page.h2?).to eq true
    end
  end
  describe '#page_text_size' do
    it 'return number of symbols on page' do
      expect(page.page_text_size).to be > 0
    end
  end
  describe '#all_a_tags' do
    it 'return all a tags on page' do
      expect(page.all_a_tags.size).to be > 0
    end
  end
  describe '#all_titles' do
    it 'return all title tags' do
      expect(page.all_titles.size).to be > 0
    end
  end
  describe '#all_meta_description_content' do
    let(:initial_values) { 'https://mail.ru' }
    it 'return all description content as array' do
      expect(page.all_meta_description_content.size).to be > 0
    end
  end
end
