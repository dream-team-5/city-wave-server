require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe '#resource_params' do
    let(:params) do
      ActionController::Parameters.new username: 'username', password: 'password'
    end

    before { allow(subject).to receive(:params).and_return params }

    its(:resource_params) { should eq params.permit! }
  end

  it_behaves_like :create, skip_authenticate: true do
    let(:resource) { stub_model Session }

    let(:success) { -> { should render_template :create } }

    let(:failure) { -> { should render_template :error } }
  end
end
