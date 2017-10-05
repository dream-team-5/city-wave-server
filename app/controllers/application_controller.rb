class ApplicationController < ActionController::Base
  include AuthenticatedController
  include RESTController
  include AuthorizedController
end
