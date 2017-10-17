class PlaceDecorator < Draper::Decorator
  delegate_all

  def as_json options={}
    if options[:short]
      super(options.reverse_merge only: [:id, :name, :address])
        .merge 'photo_url' => photo_url
    else
      super(options.reverse_merge only: [
        :id, :name, :category_id, :open_hours,
        :description, :location, :duration,
        :price, :address, :contacts, :city_id,
      ]).merge 'tag_ids' => tag_ids, 'photo_url' => photo_url
    end
  end

  def photo_url
    photo.url
  end

  def open_hours
    { begin: super.begin, end: super.end } if super.present?
  end

  def duration
    { begin: super.begin, end: super.end } if super.present?
  end
end
