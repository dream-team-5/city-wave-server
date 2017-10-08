require 'rails_helper'

RSpec.describe WishDecorator do
  subject { described_class.new wish }

  let(:wish) { stub_model Wish, text: 'text' }

  describe '#as_json' do
    its(:as_json) { should eq 'id' => wish.id, 'text' => wish.text }
  end
end
