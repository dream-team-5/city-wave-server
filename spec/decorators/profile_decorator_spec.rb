require 'rails_helper'

RSpec.describe ProfileDecorator do
  subject { described_class.new profile }

  let(:profile) { Profile.new stub_model User, username: 'username'}

  describe '#as_json' do
    its(:as_json) { should eq 'id' => profile.user_id, 'username' => profile.user_username }
  end
end
