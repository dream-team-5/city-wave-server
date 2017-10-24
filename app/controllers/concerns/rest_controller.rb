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
    if resource.update update_resource_params
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
    @resource = resource_model.new create_resource_params
  end

  def resource_params
    ActionController::Parameters.new
  end

  def update_resource_params
    resource_params
  end

  def create_resource_params
    resource_params
  end

  def create_success_callback
    respond_to do |format|
      format.html { redirect_to resource }

      format.all { render }
    end
  end

  def create_failure_callback
    respond_to do |format|
      format.any(:js, :html) { render :new }

      format.all { render_error resource.errors, 400 }
    end
  end

  def update_success_callback
    respond_to do |format|
      format.html { redirect_to resource }

      format.all { render }
    end
  end

  def update_failure_callback
    respond_to do |format|
      format.any(:js, :html) { render :edit }

      format.all { render_error resource.errors, 400 }
    end
  end

  def destroy_success_callback
    respond_to do |format|
      format.html { redirect_to action: :index }

      format.all { render }
    end
  end

  def destroy_failure_callback
    render_error resource.errors, 400
  end
end
