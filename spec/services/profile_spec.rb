require 'rails_helper'

RSpec.describe Profile do
  let(:user) { stub_model User }

  subject { described_class.new user }

  it { should delegate_method(:id).to(:user).with_prefix }

  it { should delegate_method(:username).to(:user).with_prefix }

  it { should delegate_method(:as_json).to :decorate }

  describe '#save' do
    context do
      before { expect(user).to receive(:save).and_return true }

      its(:save) { should eq true }
    end

    context do
      before { expect(user).to receive(:save).and_return false }

      before { expect(user).to receive(:errors).and_return :errors }

      its(:save) { should eq false }

      after { expect(subject.errors).to eq :errors }
    end
  end

  describe '#update' do
    before { expect(subject).to receive(:parse_params).with :params }

    context do
      let(:user) { stub_model User, roles: :registered }

      before { expect(subject).to receive :update_registered }

      before { expect(subject).to_not receive :update_basic }

      before { expect(subject).to receive(:save).and_return :save }

      it { expect(subject.update :params).to eq :save }
    end

    context do
      let(:user) { stub_model User, roles: :basic }

      before { expect(subject).to receive :update_basic }

      before { expect(subject).to_not receive :update_registered }

      before { expect(subject).to receive(:save).and_return :save }

      it { expect(subject.update :params).to eq :save }
    end
  end

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

  describe '#parse_params' do
    let(:params) do
      {
        username: 'username',
        password: 'password'
      }
    end

    before { subject.send :parse_params, params }

    its(:username) { should eq 'username' }

    its(:password) { should eq 'password' }
  end

  describe '#update_basic' do
    before { expect(subject).to receive(:username).and_return 'username' }

    before { expect(subject).to receive(:password).and_return 'password' }

    before { subject.send :update_basic }

    it { expect(user.roles).to include :registered }

    it { expect(user.username).to eq 'username' }

    it { expect(user.password).to eq 'password' }
  end

  describe '#update_registered' do
    let(:user) { stub_model User, username: 'username', password: 'password' }

    context do
      before { expect(subject).to receive(:username).and_return('new_username').twice }

      before { expect(subject).to receive(:password).and_return('new_password').twice }

      before { subject.send :update_registered }

      it { expect(user.username).to eq 'new_username' }

      it { expect(user.password).to eq 'new_password' }
    end

    context do
      before { expect(subject).to receive(:username).and_return nil }

      before { expect(subject).to receive(:password).and_return nil }

      before { subject.send :update_registered }

      it { expect(user.username).to eq 'username' }

      it { expect(user.password).to eq 'password' }
    end
  end
end
