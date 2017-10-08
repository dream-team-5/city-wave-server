class CityDecorator < Draper::Decorator
  delegate_all

  def as_json options={}
    super(options.reverse_merge only: [:id, :name])
  end
end
