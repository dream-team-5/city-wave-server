require 'rails_helper'

RSpec.describe SavedPlacesController, type: :controller do
  describe '#collection' do
    before { expect(subject).to receive(:search_params).and_return :search_params }

    before do
      expect(SavedPlaceSearcher).to receive(:search).with(:search_params) do
        double.tap { |a| expect(a).to receive(:order).with(:name).and_return :collection }
      end
    end

    its(:collection) { should eq :collection }
  end

  describe '#resource_params' do
    let(:params) { ActionController::Parameters.new place_id: 1 }

    before { allow(subject).to receive(:params).and_return params }

    before { expect(subject).to receive(:current_user).and_return :current_user }

    its(:resource_params) { should eq params.permit!.merge user: :current_user }
  end

  describe '#search_params' do
    let(:params) { ActionController::Parameters.new page: 1, name: 'name' }

    before { allow(subject).to receive(:params).and_return params }

    before { expect(subject).to receive(:current_user).and_return :current_user }

    its(:search_params) { should eq params.permit!.merge user: :current_user }
  end

  it_behaves_like :index

  it_behaves_like :create do
    let(:resource) { stub_model SavedPlace }

    let(:success) { -> { should render_template :create } }

    let(:failure) { -> { should render_template :error } }
  end
end
