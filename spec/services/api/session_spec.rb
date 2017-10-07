require 'rails_helper'

RSpec.describe Api::Session, type: :model do
  subject { described_class.new username: 'username', password: 'password' }

  it { should validate_presence_of :username }

  it { should validate_presence_of :password }

  describe '#save' do
    context do
      before { expect(subject).to receive(:valid?).and_return false }

      before { expect(subject).to_not receive :create_auth_token }

      its(:save) { should eq false }
    end

    context do
      before { expect(subject).to receive(:valid?).and_return true }

      before { expect(subject).to receive(:create_auth_token).and_return nil }

      its(:save) { should eq false }
    end

    context do
      before { expect(subject).to receive(:valid?).and_return true }

      before { expect(subject).to receive(:create_auth_token).and_return '03c9b754-5b7a-4f09-9575-132ef9088b63' }

      its(:save) { should eq true }
    end
  end

  describe '#user' do
    context do
      before { expect(User).to receive(:find_by).with(username: 'username').and_return :user }

      its(:user) { should eq :user }
    end

    context do
      subject { described_class.new username: nil }

      its(:user) { should be_nil }
    end
  end

  describe '#validate_username' do
    before { expect(subject).to receive(:user).and_return user }

    context do
      let(:user) { nil }

      it do
        expect { subject.send :validate_username }
          .to change { subject.errors[:username] }
          .by [I18n.t('errors.messages.invalid')]
      end
    end

    context do
      let(:user) { double }

      it { expect { subject.send :validate_username }.to_not change { subject.errors[:username] } }
    end
  end

  describe '#validate_password' do
    before { allow(subject).to receive(:user).and_return user }

    context do
      let(:user) { nil }

      it do
        expect { subject.send :validate_password }
          .to change { subject.errors[:password] }
          .by [I18n.t('errors.messages.invalid')]
      end
    end

    context do
      let(:user) { double }

      before { expect(user).to receive(:authenticate).with('password').and_return false }

      it do
        expect { subject.send :validate_password }
          .to change { subject.errors[:password] }
          .by [I18n.t('errors.messages.invalid')]
      end
    end

    context do
      let(:user) { double }

      before { expect(user).to receive(:authenticate).with('password').and_return true }

      it { expect { subject.send :validate_password }.to_not change { subject.errors[:password] } }
    end

    context do
      let(:user) { nil }

      subject { described_class.new password: nil }

      it { expect { subject.send :validate_password }.to_not change { subject.errors[:password] } }
    end
  end

  describe '#create_auth_token' do
    before do
      expect(subject).to receive(:user) do
        double.tap do |user|
          expect(user).to receive(:auth_tokens) do
            double.tap { |auth_tokens| expect(auth_tokens).to receive(:create).and_return auth_token }
          end
        end
      end
    end

    context do
      let(:auth_token) { stub_model(AuthToken).as_new_record }

      its(:create_auth_token) { should eq nil }

      after { expect(subject.instance_variable_get :@auth_token).to eq nil }
    end

    context do
      let(:auth_token) { stub_model AuthToken }

      its(:create_auth_token) { should eq auth_token.id }

      after { expect(subject.instance_variable_get :@auth_token).to eq auth_token.id }
    end
  end
end
