require 'rails_helper'

RSpec.describe SavedPlacesController, type: :controller do
  describe '#collection' do
    before do
      expect(subject).to receive(:current_user) do
        double.tap { |a| expect(a).to receive(:saved_places).and_return :collection }
      end
    end

    its(:collection) { should eq :collection }
  end

  it_behaves_like :index

  it_behaves_like :create do
    let(:resource) { double }

    let(:success) { -> { should render_template :create } }

    let(:failure) { -> { should render_template :error } }
  end
end
