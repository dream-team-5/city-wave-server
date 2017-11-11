require 'rails_helper'

RSpec.describe CommentDecorator do
  subject { described_class.new comment }

  let(:user) { stub_model User, username: 'username' }

  let(:comment) { stub_model Comment, text: 'text', created_at: DateTime.now, user: user, place_id: 1 }

  describe '#as_json' do
    its(:as_json) do
      should eq \
        'id' => comment.id, 'text' => comment.text,
        'created_at' => comment.created_at,
        'username' => 'username',
        'place_id' => comment.place_id
    end
  end

  describe '#username' do
    its(:username) { should eq 'username' }
  end
end
