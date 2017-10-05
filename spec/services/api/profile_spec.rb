require 'rails_helper'

RSpec.describe Api::Profile do
  describe '#user' do
    context do
      subject { described_class.new :user }

      its(:user) { should eq :user }
    end

    context do
      subject { described_class.new nil }

      before { expect(User).to receive(:new).with(roles: :basic).and_return :user }

      its(:user) { should eq :user }
    end
  end

  let(:user) { stub_model User }

  subject { described_class.new user }

  describe '#create_registered' do
    context do
      let(:params) do
        ActionController::Parameters.new password: 'password', username: 'username'
      end

      before do
        # user.roles << :registered
        expect(user).to receive(:roles) do
          double.tap { |a| expect(a).to receive(:<<).with :registered }
        end
      end

      context do
        before { expect(user).to receive(:update).with(password: 'password', username: 'username').and_return true }

        it { expect(subject.send :create_registered, params).to eq true }
      end

      context do
        before { expect(user).to receive(:update).with(password: 'password', username: 'username').and_return false }

        it { expect(subject.send :create_registered, params).to eq false }
      end
    end

    context do
      let(:params) do
        ActionController::Parameters.new password: 'password'
      end

      before { expect(user).to_not receive(:update) }

      it { expect { subject.send :create_registered, params }.to raise_error ActionController::ParameterMissing }
    end

    context do
      let(:params) do
        ActionController::Parameters.new username: 'username'
      end

      before { expect(user).to_not receive(:update) }

      it { expect { subject.send :create_registered, params }.to raise_error ActionController::ParameterMissing }
    end
  end

  describe '#update_registered' do
    context do
      let(:params) do
        ActionController::Parameters.new password: 'password', username: 'username', new_password: 'new_password'
      end

      context do
        before { expect(user).to receive(:authenticate).with('password').and_return false }

        it { expect(subject.send :update_registered, params).to eq false }
      end

      context do
        before { expect(user).to receive(:authenticate).with('password').and_return true }

        context do
          before { expect(user).to receive(:update).with(password: 'new_password', username: 'username').and_return false }

          it { expect(subject.send :update_registered, params).to eq false }
        end

        context do
          before { expect(user).to receive(:update).with(password: 'new_password', username: 'username').and_return true }

          it { expect(subject.send :update_registered, params).to eq true }
        end
      end
    end

    context do
      let(:params) do
        ActionController::Parameters.new username: 'username', new_password: 'new_password'
      end

      before { expect(user).to_not receive(:update) }

      it { expect { subject.send :create_registered, params }.to raise_error ActionController::ParameterMissing }
    end
  end

  describe '#update' do
    context do
      let(:user) { stub_model User, roles: [:basic, :registered] }

      before { expect(subject).to_not receive :create_registered }

      before { expect(subject).to receive(:update_registered).and_return :update_registered }

      it { expect(subject.update nil).to eq :update_registered }
    end

    context do
      let(:user) { stub_model User, roles: :basic }

      before { expect(subject).to_not receive :update_registered }

      before { expect(subject).to receive(:create_registered).and_return :create_registered }

      it { expect(subject.update nil).to eq :create_registered }
    end

    context do
      let(:user) { stub_model User }

      before { expect(subject).to_not receive :update_registered }

      before { expect(subject).to_not receive :create_registered }

      it { expect(subject.update nil).to eq false }
    end
  end
end
