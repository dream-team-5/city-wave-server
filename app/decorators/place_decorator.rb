class PlaceDecorator < Draper::Decorator
  delegate_all

  def as_json options={}
    if options[:short]
      super(options.reverse_merge only: [:id, :name, :address])
        .merge 'photo_url' => photo_url
    else
      super(options.reverse_merge only: [
        :id, :name, :category_id, :price, :city_id,
        :description, :location, :address, :contacts
      ]).merge 'tag_ids' => tag_ids, 'photo_url' => photo_url
    end
  end

  def photo_url
    photo.url :mobile
  end
end
