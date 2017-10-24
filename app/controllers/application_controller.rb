class ApplicationController < ActionController::Base
  rescue_from StandardError,
              Object,
              with: -> e { render_error e.to_s, 500 }

  rescue_from ActiveRecord::RecordInvalid,
              ActiveRecord::RecordNotSaved,
              ActionDispatch::Http::Parameters::ParseError,
              ActionController::BadRequest,
              ActionController::ParameterMissing,
              Rack::QueryParser::ParameterTypeError,
              Rack::QueryParser::InvalidParameterError,
              with: -> e { render_error e.to_s, 400 }

  rescue_from ActiveRecord::RecordNotFound,
              ActionController::RoutingError,
              AbstractController::ActionNotFound,
              with: -> e { render_error e.to_s, 404 }

  include AuthenticatedController
  include RESTController
  include AuthorizedController

  helper_method :error_description

  private
  def render_error description, status
    @error_description = description

    respond_to do |format|
      format.json { render :error, status: status, layout: false }

      format.all { render :error, status: status }
    end
  end

  attr_reader :error_description

  private :error_description

  class << self
    private
    def responds_to *formats
      options = formats.extract_options!

      before_action -> { respond_to(*formats) }, options
    end
  end
end
