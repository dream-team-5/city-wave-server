RSpec.shared_examples :show do |params|
  let(:default_params) { { skip_authenticate: false, format: :json, params: { id: 1 } } }

  let(:resource) { double }

  include_examples :parse_params, params

  include_examples :authenticate_user

  include_examples :authorize_resource

  include_examples :has_policy

  describe '#show' do
    before { get :show, params: request_params, format: request_format }

    it { should render_template :show }
  end
end

RSpec.shared_examples :new do |params|
  let(:default_params) { { skip_authenticate: false, format: :json, params: {} } }

  let(:resource) { :resource }

  include_examples :parse_params, params

  include_examples :authenticate_user

  include_examples :authorize_resource

  include_examples :has_policy

  describe '#new' do
    before { expect(subject).to receive(:initialize_resource) }

    before { get :new, params: request_params, format: request_format }

    it { should render_template :new }
  end
end

RSpec.shared_examples :create do |params|
  let(:default_params) { { skip_authenticate: false, format: :json, params: {} } }

  include_examples :parse_params, params

  include_examples :authenticate_user

  include_examples :authorize_resource

  include_examples :has_policy

  describe '#create' do
    before { expect(subject).to receive(:build_resource) }

    context do
      before { expect(resource).to receive(:save).and_return(true) }

      before { post :create, params: request_params, format: request_format }

      it { success.call }
    end

    context do
      before { expect(resource).to receive(:save).and_return(false) }

      before { post :create, params: request_params, format: request_format }

      it { failure.call }
    end
  end
end

RSpec.shared_examples :edit do |params|
  let(:default_params) { { skip_authenticate: false, format: :json, params: { id: 1 } } }

  let(:resource) { :resource }

  include_examples :parse_params, params

  include_examples :authenticate_user

  include_examples :authorize_resource

  include_examples :has_policy

  describe '#edit' do
    before { get :edit, params: request_params, format: request_format }

    it { should render_template :edit }
  end
end

RSpec.shared_examples :update do |params|
  let(:default_params) { { skip_authenticate: false, format: :json, params: { id: 1 } } }

  include_examples :parse_params, params

  include_examples :authenticate_user

  include_examples :authorize_resource

  include_examples :has_policy

  describe '#update' do
    before { expect(subject).to receive(:update_resource_params).and_return(:update_resource_params) }

    context do
      before { expect(resource).to receive(:update).with(:update_resource_params).and_return(true) }

      before { patch :update, params: request_params, format: request_format }

      it { success.call }
    end

    context do
      before { expect(resource).to receive(:update).with(:update_resource_params).and_return(false) }

      before { patch :update, params: request_params, format: request_format }

      it { failure.call }
    end
  end
end

RSpec.shared_examples :destroy do |params|
  let(:default_params) { { skip_authenticate: false, format: :json, params: { id: 1 } } }

  let(:resource) { double }

  include_examples :parse_params, params

  include_examples :authenticate_user

  include_examples :authorize_resource

  include_examples :has_policy

  describe '#destroy' do
    before { expect(resource).to receive(:destroy) }

    before { delete :destroy, params: request_params, format: request_format }

    it { success.call }
  end
end

RSpec.shared_examples :index do |params|
  let(:default_params) { { skip_authenticate: false, format: :json, params: {} } }

  let(:resource) { :resource }

  include_examples :parse_params, params

  include_examples :authenticate_user

  include_examples :has_policy

  describe '#index' do
    before { expect(subject).to receive(:collection).and_return(:collection) }

    before { expect(subject).to receive(:authorize).with(:collection).and_return(true) }

    before { get :index, params: request_params, format: request_format }

    it { should render_template :index }
  end
end

#
# Helpers
#

RSpec.shared_examples :parse_params do |params|
  let(:skip_authenticate) { (params && params[:skip_authenticate]) || default_params[:skip_authenticate] }

  let(:request_format) { (params && params[:format]) || default_params[:format] }

  let(:request_params) { (params && params[:params]) || default_params[:params] }
end

RSpec.shared_examples :authenticate_user do
  before { expect(subject).to receive(:authenticate) unless skip_authenticate }

  before { expect(subject).to_not receive(:authenticate) if skip_authenticate }
end

RSpec.shared_examples :authorize_resource do
  before { allow(subject).to receive(:resource).and_return(resource) }

  before { expect(subject).to receive(:authorize).with(resource).and_return(true) }
end

RSpec.shared_examples :has_policy do
  before { expect { Pundit::PolicyFinder.new(described_model).policy! }.to_not raise_error }
end

class RSpec::Core::ExampleGroup
  def described_model
    described_class.name.gsub(/Controller\z/, '').singularize.constantize
  end
end
