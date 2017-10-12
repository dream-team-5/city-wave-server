require 'rails_helper'

RSpec.describe TagDecorator do
  subject { described_class.new tag }

  let(:tag) { stub_model Tag, name: 'name' }

  describe '#as_json' do
    its(:as_json) { should eq 'id' => tag.id, 'name' => tag.name }
  end
end
