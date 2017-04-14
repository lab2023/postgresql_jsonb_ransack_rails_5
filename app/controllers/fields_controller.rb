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
    @field.valid?
    @field.validate_key
    unless @field.errors.any?
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
    @field = Field.new(@user.fields[@resource][@key])
    @field.key = @key
  end

  def update
    @field = Field.new(params_field)
    if @field.valid?
      @user.fields[@resource][@key] = @field.as_json
      @user.save
      flash[:success] = 'Field updated successfully'
      redirect_to @user
    else
      @field.errors.delete(:key)
      flash.now[:danger] = 'Invalid field parameters!'
      @field.key = @key
      render :edit
    end
  end

  def destroy
    @user.fields[@resource].delete(@key) if @user.fields[@resource].present?
    @user.save
    flash[:success] = 'Field destroyed successfully'
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
