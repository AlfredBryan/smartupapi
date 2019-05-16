module Api::V1::ExceptionHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found
    rescue_from ActionController::ParameterMissing, :with => :not_found
    rescue_from Pundit::NotDefinedError, :with => :not_found
    rescue_from Pundit::NotAuthorizedError, with: :not_found

    def not_found(exception)
      respond_to do |format|
        h = { :status => "error", :message => exception.message }
        format.json { render :json => h, :status => :not_found }
      end
    end
  end
end
