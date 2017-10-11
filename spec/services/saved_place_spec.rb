require 'rails_helper'

RSpec.describe SavedPlace, type: :model do
  subject { described_class.new({}) }

  it { should delegate_method(:as_json).to :place }

  it { should validate_presence_of :place_id }

  describe '#save' do
    subject { described_class.new place_id: 1, user: user }

    let(:user) { stub_model User }

    context do
      before { expect(subject).to receive(:valid?).and_return false }

      before { expect(user).to_not receive :saved_places }

      before { expect(subject).to_not receive :place }

      its(:save) { should eq false }
    end

    context do
      before { expect(subject).to receive(:valid?).and_return true }

      before { expect(subject).to receive(:place).and_return :place }

      before do
        expect(user).to receive(:saved_places) do
          double.tap { |a| expect(a).to receive(:<<).with(:place).and_return nil }
        end
      end

      its(:save) { should eq false }
    end

    context do
      before { expect(subject).to receive(:valid?).and_return true }

      before { expect(subject).to receive(:place).and_return :place }

      before do
        expect(user).to receive(:saved_places) do
          double.tap { |a| expect(a).to receive(:<<).with(:place).and_return :result }
        end
      end

      its(:save) { should eq true }
    end
  end

  describe '#place' do
    context do
      subject { described_class.new place_id: nil }

      before { expect(Place).to_not receive :find }

      its(:place) { should be_nil }
    end

    context do
      subject { described_class.new place_id: 1 }

      before { expect(Place).to receive(:find).with(1).and_return :place }

      its(:place) { should eq :place }
    end
  end
end
