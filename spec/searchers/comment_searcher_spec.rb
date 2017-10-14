require 'rails_helper'

describe CommentSearcher do
  let(:collection) { double }

  let(:user) { double }

  describe '#search_by_page' do
    before { expect(user).to receive(:comments).and_return(collection) }

    before { expect(collection).to receive(:page).with(1).and_return :collection }

    subject { described_class.search page: 1, user: user }

    it { should eq :collection }
  end

  describe '#search_by_place_id' do
    before { expect(Comment).to receive(:all).and_return(collection) }

    before { expect(collection).to receive(:where).with(place_id: 1).and_return :collection }

    subject { described_class.search place_id: 1 }

    it { should eq :collection }
  end

  describe '#initialize_results' do
    before { allow(subject).to receive :search_by_page }

    before { allow(subject).to receive :search_by_place_id }

    context do
      subject { described_class.new place_id: 1, user: user, page: 1 }

      before { expect(user).to_not receive(:comments) }

      before { expect(Comment).to receive(:all).and_return(collection) }

      it { expect { subject.search }.to_not raise_error }
    end

    context do
      subject { described_class.new user: user, page: 1 }

      before { expect(user).to receive(:comments).and_return collection }

      it { expect { subject.search }.to_not raise_error }
    end
  end
end
