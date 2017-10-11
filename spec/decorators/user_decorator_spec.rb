require 'rails_helper'

RSpec.describe UserDecorator do
  subject { described_class.new user }

  describe '#basic?' do
    context do
      let(:user) { stub_model User, roles: :basic }

      its(:basic?) { should eq true }
    end

    context do
      let(:user) { stub_model User, roles: [:registered, :admin] }

      its(:basic?) { should eq false }
    end
  end

  describe '#registered?' do
    context do
      let(:user) { stub_model User, roles: :registered }

      its(:registered?) { should eq true }
    end

    context do
      let(:user) { stub_model User, roles: [:basic, :admin] }

      its(:registered?) { should eq false }
    end
  end

  describe '#admin?' do
    context do
      let(:user) { stub_model User, roles: :admin }

      its(:admin?) { should eq true }
    end

    context do
      let(:user) { stub_model User, roles: [:registered, :basic] }

      its(:admin?) { should eq false }
    end
  end

  describe '#as_json' do
    let(:user) { stub_model User, username: 'username', roles: [:admin, :registered, :basic] }

    its(:as_json) { should eq 'id' => user.id, 'username' => user.username, 'roles' => user.roles }
  end
end
