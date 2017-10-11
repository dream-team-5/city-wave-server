require 'rails_helper'

describe PlaceSearcher do
  let(:collection) { double }

  before { expect(Place).to receive(:all).and_return(collection) }

  describe '#search_by_category_id' do
    before do
      #
      # collection.joins(:category).where(categories: { id: 1 }) -> :collection
      #
      expect(collection).to receive(:joins).with(:category) do
        double.tap { |a| expect(a).to receive(:where).with(categories: { id: 1 }).and_return :collection }
      end
    end

    subject { described_class.search category_id: 1 }

    it { should eq :collection }
  end

  describe '#search_by_tag_id' do
    before do
      #
      # collection.joins(:tags).where(tags: { id: 1 }) -> :collection
      #
      expect(collection).to receive(:joins).with(:tags) do
        double.tap { |a| expect(a).to receive(:where).with(tags: { id: 1 }).and_return :collection }
      end
    end

    subject { described_class.search tag_id: 1 }

    it { should eq :collection }
  end

  describe '#search_by_city_id' do
    before do
      #
      # collection.joins(:city).where(cities: { id: 1 }) -> :collection
      #
      expect(collection).to receive(:joins).with(:city) do
        double.tap { |a| expect(a).to receive(:where).with(cities: { id: 1 }).and_return :collection }
      end
    end

    subject { described_class.search city_id: 1 }

    it { should eq :collection }
  end

  describe '#search_by_page' do
    before { expect(collection).to receive(:page).with(1).and_return :collection }

    subject { described_class.search page: 1 }

    it { should eq :collection }
  end

  describe '#search_by_name' do
    before { expect(collection).to receive(:search_by_name).with('name').and_return :collection }

    subject { described_class.search name: 'name' }

    it { should eq :collection }
  end
end
