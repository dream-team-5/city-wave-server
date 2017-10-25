require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  describe '#resource_model' do
    its(:resource_model) { should eq User }
  end

  describe '#resource_params' do
    let(:params) do
      ActionController::Parameters.new user: { username: 'username', password: 'password', roles: ['basic'] }
    end

    before { allow(subject).to receive(:params).and_return params }

    its(:resource_params) { should eq params[:user].permit! }
  end

  let(:described_model) { User }

  it_behaves_like :index, format: :html

  it_behaves_like :show, format: :js

  it_behaves_like :new, format: :js

  it_behaves_like :create, format: :js do
    let(:resource) { stub_model User }

    let(:success) { -> { should render_template :create } }

    let(:failure) { -> { should render_template :new } }
  end

  it_behaves_like :edit, format: :js

  it_behaves_like :update, format: :js do
    let(:resource) { stub_model User }

    let(:success) { -> { should render_template :update } }

    let(:failure) { -> { should render_template :edit } }
  end

  it_behaves_like :destroy, format: :js do
    let(:resource) { stub_model User }

    let(:success) { -> { should render_template :destroy } }

    let(:failure) { -> { should render_template :error } }
  end
end
