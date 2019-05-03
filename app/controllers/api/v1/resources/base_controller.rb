class Api::V1::Resources::BaseController < Api::V1::BaseController
  after_action :verify_authorized, :except => :index
  after_action :verify_policy_scoped, :only => :index
  before_action :authenticate_with_token!

  def create
    authorize(instance)
    instance.attributes = self.send("#{controller_name.singularize}_params".to_sym)
    respond_to do |format|
      format.json {
        if instance.save && instance.valid?
          render json: instance, serializer: serializer
        else
          render json: instance, serializer: serializer, status: :unprocessable_entity
        end
      }
    end
  end

  def show
    authorize(instance)
    respond_to do |format|
      format.json {
        render json: instance, serializer: serializer
      }
    end
  end

  def update
    authorize(instance)
    respond_to do |format|
      format.json {
        if instance.update_attributes(self.send("#{controller_name.singularize}_params".to_sym)) && instance.valid?
          render json: instance, serializer: serializer
        else
          render json: instance, serializer: serializer, status: :unprocessable_entity
        end
      }
    end
  end

  private

  def instance
    @instance ||= eval("@#{controller_name.singularize}")
  end

  def serializer
    @serializer ||= "#{controller_name.singularize.classify}Serializer".constantize
  end
end
