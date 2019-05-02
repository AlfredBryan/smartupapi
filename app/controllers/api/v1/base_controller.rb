class Api::V1::BaseController < ApplicationController

  respond_to :json

  skip_before_action :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  # skip_before_action :authenticate_user!
  include Authenticable

end