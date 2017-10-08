require 'rails_helper'

RSpec.describe CategoryDecorator do
  subject { described_class.new category }

  let(:category) { stub_model Category, name: 'name'}

  describe '#as_json' do
    its(:as_json) { should eq 'id' => category.id, 'name' => category.name }
  end
end
