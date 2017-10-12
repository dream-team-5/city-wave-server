require 'rails_helper'

describe CommentSearcher do
  let(:collection) { double }

  before { expect(Comment).to receive(:all).and_return(collection) }

  describe '#search_by_page' do
    before { expect(collection).to receive(:page).with(1).and_return :collection }

    subject { described_class.search page: 1 }

    it { should eq :collection }
  end

  describe '#search_by_place_id' do
    before { expect(collection).to receive(:where).with(place_id: 1).and_return :collection }

    subject { described_class.search place_id: 1 }

    it { should eq :collection }
  end

  describe '#search_by_user_id' do
    before { expect(collection).to receive(:where).with(user_id: 1).and_return :collection }

    subject { described_class.search user_id: 1 }

    it { should eq :collection }
  end
end
