require 'rails_helper'

RSpec.describe PlaceDecorator do
  subject { described_class.new place }

  let(:place) do
    stub_model Place, \
      city_id: 1, category_id: 1, name: 'name',
      price: 42.24, description: 'description', address: 'address',
      location: ActiveRecord::Point.new(1, 2), contacts: 'contacts',
      open_hours: Time.parse('8:00:00')..Time.parse('18:00:00'),
      duration: Date.parse('01.01.2017')..Date.parse('01.01.2018')
  end

  describe '#as_json' do
    before { expect(subject).to receive(:photo_url).and_return 'photo_url' }

    context do
      it do
        expect(subject.as_json short: true).to eq \
          'id' => place.id, 'photo_url' => 'photo_url',
          'name' => place.name, 'address' => place.address
      end
    end

    context do
      before { expect(place).to receive(:tag_ids).and_return [1, 2] }

      its(:as_json) do
        should eq \
          'id' => place.id, 'tag_ids' => [1, 2], 'name' => place.name,
          'city_id' => place.city_id, 'category_id' => place.category_id,
          'description' => place.description, 'photo_url' => 'photo_url',
          'price' => place.price,'address' => place.address,
          'location' => place.location, 'contacts' => place.contacts,
          'open_hours' => { begin: place.open_hours.begin, end: place.open_hours.end },
          'duration' => { begin: place.duration.begin, end: place.duration.end }
      end
    end
  end

  describe '#open_hours' do
    context do
      let(:place) { stub_model Place }

      its(:open_hours) { should be_nil }
    end

    context do
      its(:open_hours) { should eq begin: place.open_hours.begin, end: place.open_hours.end }
    end
  end

  describe '#duration' do
    context do
      let(:place) { stub_model Place }

      its(:duration) { should be_nil }
    end

    context do
      its(:duration) { should eq begin: place.duration.begin, end: place.duration.end }
    end
  end

  describe '#photo_url' do
    before do
      expect(place).to receive(:photo) do
        double.tap { |a| expect(a).to receive(:url).with(:mobile).and_return '/photo_url' }
      end
    end

    its(:photo_url) { should eq '/photo_url' }
  end
end
