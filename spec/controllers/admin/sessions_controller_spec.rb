require 'rails_helper'

RSpec.describe Admin::SessionsController, type: :controller do
  describe '#resource' do
    its(:resource) { should eq described_model }
  end

  describe '#resource_params' do
    let(:params) do
      ActionController::Parameters.new admin_session: { username: 'username', password: 'password' }
    end

    before { allow(subject).to receive(:params).and_return params }

    its(:resource_params) { should eq params[:admin_session].permit! }
  end

  it_behaves_like :new, skip_authenticate: true, format: :html

  it_behaves_like :show, format: :html

  it_behaves_like :create, skip_authenticate: true, format: :html do
    let(:resource) { stub_model Admin::Session }

    let(:success) { -> { should redirect_to action: :show } }

    let(:failure) { -> { should render_template :new } }
  end
end
