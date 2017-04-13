class FieldsController < ApplicationController

  before_action :set_user
  before_action :set_resource
  before_action :set_key, only: [:edit, :update, :destroy]

  def new
  end

  def create
    field = set_field_hash
    key = params_field_key[:key]
    if key.present? && field[:name].present? && field[:type].present?
      key = key.parameterize.underscore
      @user.fields[@resource][key] = field
      @user.save
      redirect_to @user
    else
      @message = 'Invalid field parameters!'
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @user.fields[@resource].delete(@key) if @user.fields[@resource].present?
    @user.save
    redirect_to @user
  end

  private

    def params_field
      params.require(:field).permit(:name, :type, :is_filter_exist, :is_sort_exist)
    end

    def params_field_key
      params.require(:field).permit(:key)
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_resource
      @resource = params[:resource]
    end

    def set_key
      @key = params[:key]
    end

    def set_field_hash
      field = {
          name: nil,
          type: nil,
          is_filter_exist: false,
          is_sort_exist: false
      }
      parameters = params_field
      field[:name] = parameters[:name]
      field[:type] = parameters[:type]
      field[:is_filter_exist] = parameters[:is_filter_exist] == 'on'
      field[:is_sort_exist] = parameters[:is_sort_exist] == 'on'
      field
    end
end
