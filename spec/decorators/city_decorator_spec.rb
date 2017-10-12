require 'rails_helper'

RSpec.describe CityDecorator do
  subject { described_class.new city }

  let(:city) { stub_model City, name: 'name' }

  describe '#as_json' do
    its(:as_json) { should eq 'id' => city.id, 'name' => city.name }
  end
end
