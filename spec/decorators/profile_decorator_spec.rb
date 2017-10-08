require 'rails_helper'

RSpec.describe ProfileDecorator do
  subject { described_class.new profile }

  let(:profile) { Profile.new stub_model User, username: 'username'}

  describe '#to_json' do
    let(:json) { { 'id' => profile.user_id, 'username' => profile.user_username } }

    it { expect(JSON.parse subject.to_json).to eq json }
  end
end
