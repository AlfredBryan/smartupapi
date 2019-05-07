class Api::V1::BaseController < ApplicationController
  include Api::V1::ExceptionHandlers

  respond_to :json

  skip_before_action :verify_authenticity_token
  protect_from_forgery with: :null_session
  include Authenticable

end