require 'rails_helper'

describe SavedPlaceSearcher do
  let(:collection) { double }

  let(:user) { double }

  before { expect(user).to receive(:saved_places).and_return(collection) }

  describe '#search_by_page' do
    before { expect(collection).to receive(:page).with(1).and_return :collection }

    subject { described_class.search page: 1, user: user }

    it { should eq :collection }
  end

  describe '#search_by_name' do
    before { expect(collection).to receive(:search_by_name).with('name').and_return :collection }

    subject { described_class.search name: 'name', user: user }

    it { should eq :collection }
  end
end
