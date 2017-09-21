module RESTController
  extend ActiveSupport::Concern

  included do
    helper_method :collection, :resource

    before_action :build_resource, only: :create

    before_action :initialize_resource, only: :new
  end

  def create
    if resource.save
      create_success_callback
    else
      create_failure_callback
    end
  end

  def update
    if resource.update resource_params
      update_success_callback
    else
      update_failure_callback
    end
  end

  def destroy
    if resource.destroy
      destroy_success_callback
    else
      destroy_failure_callback
    end
  end

  private
  #
  # CategoriesController => Category
  #
  def resource_model
    @resource_model ||= self.class.name.gsub(/Controller\z/, '').singularize.constantize
  end

  def collection
    @collection ||= resource_model.all
  end

  def resource
    @resource ||= resource_model.find params[:id]
  end

  def initialize_resource
    @resource = resource_model.new
  end

  def build_resource
    @resource = resource_model.new resource_params
  end

  def resource_params
    ActionController::Parameters.new
  end

  def create_success_callback
    render
  end

  def create_failure_callback
    render :errors
  end

  def update_success_callback
    render
  end

  def update_failure_callback
    render :errors
  end

  def destroy_success_callback
    render
  end

  def destroy_failure_callback
    render :errors
  end
end
