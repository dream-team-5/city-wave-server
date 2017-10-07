require 'rails_helper'

RSpec.describe Api::ProfilesController, type: :controller do
  it_behaves_like :show

  it_behaves_like :create, skip_authenticate: true do
    let(:resource) { double }

    let(:success) { -> { should render_template :create } }

    let(:failure) { -> { should render_template :error } }
  end

  it_behaves_like :update do
    let(:resource) { double }

    let(:success) { -> { should render_template :update } }

    let(:failure) { -> { should render_template :error } }
  end
end
