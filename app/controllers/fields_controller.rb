class FieldsController < ApplicationController

  before_action :set_user
  before_action :set_resource
  before_action :set_key, only: [:edit, :update, :destroy]

  def new
    @field = Field.new
  end

  def create
    @field = Field.new(params_field)
    @field.key_parameterize
    Rails.logger.info @field.as_json.inspect.red
    if @field.valid?
      @user.fields[@resource][@field.key] = @field.as_json
      @user.save
      flash[:success] = 'Field added successfully'
      redirect_to @user
    else
      flash.now[:danger] = 'Invalid field parameters!'
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
      params.require(:field).permit(:key, :name, :type, :is_filter_exist, :is_sort_exist)
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

end
