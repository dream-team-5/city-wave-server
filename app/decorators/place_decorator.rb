class PlaceDecorator < Draper::Decorator
  delegate_all

  def as_json options={}
    if options[:short]
      super options.reverse_merge \
        only: [:id, :name, :address],
        methods: [:photo_url]
    else
      super options.reverse_merge \
        only: [
          :id, :name, :category_id, :price, :city_id, :latitude,
          :description, :longitude, :address, :contacts
        ],
        methods: [:tag_ids, :photo_url]
    end
  end

  def photo_url
    photo.url :mobile
  end
end
