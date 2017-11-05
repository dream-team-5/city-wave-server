require 'rails_helper'

RSpec.describe Admin::PlacesController, type: :controller do
  describe '#resource_model' do
    its(:resource_model) { should eq Place }
  end

  describe '#resource_params' do
    let(:params) do
      ActionController::Parameters.new place: \
      {
        city_id: 1,
        category_id: 2,
        name: 'name',
        description: 'description',
        address: 'address',
        latitude: 5.0,
        longitude: 6.0,
        contacts: 'contacts',
        price: 23.42,
        photo: 'photo',
        tag_ids: [3, 4]
      }
    end

    before { allow(subject).to receive(:params).and_return params }

    its(:resource_params) { should eq params[:place].permit! }
  end

  let(:described_model) { Place }

  it_behaves_like :index, format: :html

  it_behaves_like :show, format: :js

  it_behaves_like :new, format: :js

  it_behaves_like :create, format: :js do
    let(:resource) { stub_model Place }

    let(:success) { -> { should render_template :create } }

    let(:failure) { -> { should render_template :new } }
  end

  it_behaves_like :edit, format: :js

  it_behaves_like :update, format: :js do
    let(:resource) { stub_model Place }

    let(:success) { -> { should render_template :update } }

    let(:failure) { -> { should render_template :edit } }
  end

  it_behaves_like :destroy, format: :js do
    let(:resource) { stub_model Place }

    let(:success) { -> { should render_template :destroy } }

    let(:failure) { -> { should render_template :error } }
  end
end
