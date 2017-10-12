require 'rails_helper'

RSpec.describe CommentDecorator do
  subject { described_class.new comment }

let(:comment) { stub_model Comment, text: 'text', created_at: DateTime.now, user_id: 1, place_id: 1 }

  describe '#as_json' do
    its(:as_json) do
      should eq \
        'id' => comment.id, 'text' => comment.text,
        'created_at' => comment.created_at,
        'user_id' => comment.user_id,
        'place_id' => comment.place_id
    end
  end
end
