require 'rails_helper'

RSpec.describe SessionDecorator do
  subject { described_class.new session }

  let(:session) { Session.new({}) }

  describe '#to_json' do
    before { expect(session).to receive(:auth_token).and_return 'auth_token' }

    its(:as_json) { should eq 'auth_token' }
  end
end
