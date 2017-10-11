require 'rails_helper'

RSpec.describe PlacesController, type: :controller do
  describe '#search_params' do
    let(:params) do
      ActionController::Parameters.new category_id: 1, city_id: 1, tag_id: 1, page: 1, name: 'name'
    end

    before { allow(subject).to receive(:params).and_return params }

    its(:search_params) { should eq params.permit! }
  end

  describe '#collection' do
    before { expect(subject).to receive(:search_params).and_return :search_params }

    before do
      #
      # PlaceSearcher.search(search_params).order :name -> :collection
      #
      expect(PlaceSearcher).to receive(:search).with(:search_params) do
        double.tap { |a| expect(a).to receive(:order).with(:name).and_return :collection }
      end
    end

    its(:collection) { should eq :collection }
  end

  it_behaves_like :index, params: { category_id: 1 }

  it_behaves_like :index, params: { city_id: 1 }

  it_behaves_like :index, params: { tag_id: 1 }

  it_behaves_like :show
end
