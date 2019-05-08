module Api::V1::ExceptionHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, :with => :not_found
    rescue_from ActionController::ParameterMissing, :with => :not_found
    rescue_from Pundit::NotDefinedError, :with => :not_found
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def not_found(exception)
      respond_to do |format|
        h = { :status => "error", :message => exception.message }
        format.json { render :json => h, :status => :not_found }
      end
    end

    def user_not_authorized
      flash[:error] = "You are not authorized to perform this action."
      redirect_to request.headers["Referer"] || root_path
    end
  end
end
