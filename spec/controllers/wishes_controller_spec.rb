require 'rails_helper'

RSpec.describe WishesController, type: :controller do
  describe '#resource' do
    before { expect(described_model).to receive(:count).and_return 10 }

    before { expect(subject).to receive(:rand).with(10).and_return 2 }

    before do
      expect(described_model).to receive(:offset).with(2) do
        double.tap { |a| expect(a).to receive(:first).and_return :wish }
      end
    end

    its(:resource) { should eq :wish }
  end

  it_behaves_like :show
end
