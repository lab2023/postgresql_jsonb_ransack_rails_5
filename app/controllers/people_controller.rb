class PeopleController < ApplicationController

  before_action :set_user
  before_action :set_fields
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    @person.metadata = person_metadata_params
    if @person.save
      flash[:success] = 'Person created successfully'
      redirect_to user_person_path(@user, @person)
    else
      flash.now[:danger] = 'Invalid person parameters!'
      render :new
    end
  end

  def edit
  end

  def update
    @person.metadata = person_metadata_params
    if @person.update(person_params)
      flash[:success] = 'Person updated successfully'
      redirect_to user_person_path(@user, @person)
    else
      flash.now[:danger] = 'Invalid person parameters!'
      render :edit
    end
  end

  def show
  end

  def destroy
    @person.destroy
    flash[:success] = 'Person destroyed successfully'
    redirect_to @user
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_person
      @person = Person.find(params[:id])
    end

    def set_fields
      @fields = @user.fields['person']
    end

    def person_params
      params.require(:person).permit(:name, :surname, :age, :email)
    end

    def person_metadata_params
      parameters = @fields.keys
      params.require(:person).permit(parameters).to_hash
    end

end
