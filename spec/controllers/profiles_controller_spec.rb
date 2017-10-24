require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  describe '#create_resource_params' do
    its(:create_resource_params) { should be_nil }
  end

  describe '#update_resource_params' do
    let(:params) do
      ActionController::Parameters.new username: 'username', password: 'password'
    end

    before { allow(subject).to receive(:params).and_return params }

    its(:update_resource_params) { should eq params.permit! }
  end

  it_behaves_like :show

  it_behaves_like :create, skip_authenticate: true do
    let(:resource) { stub_model Profile }

    let(:success) { -> { should render_template :create } }

    let(:failure) { -> { should render_template :error } }
  end

  it_behaves_like :update do
    let(:resource) { stub_model Profile }

    let(:success) { -> { should render_template :update } }

    let(:failure) { -> { should render_template :error } }
  end
end
