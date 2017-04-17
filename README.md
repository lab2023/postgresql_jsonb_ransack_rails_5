# Rails user based custom field example with postgresql jsonb and using custom fields with ransack  

Demo: https://rails-custom-field-ransack.herokuapp.com

This example project for using custom field in rails. You can add new fields, and new resources related with your fields.

Virtual attribute for custom field:

```ruby
class Field
  include ActiveModel::Validations
  include ActiveModel::Conversion

  attr_accessor :name, :type, :key, :is_filter_exist, :is_sort_exist

  validates_presence_of :name, :type
  validates_inclusion_of :type, in: %w(number text)

  def initialize(attributes = {})
    self.is_filter_exist = false
    self.is_sort_exist = false
    attributes.each do |name, value|
      if name.in?(%w(is_filter_exist is_sort_exist))
        value = value.to_s.in?( %w(1 true) )
      end
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def validate_key
    validates_length_of :key, maximum: 100
    validates_presence_of :key
  end

  def key_parameterize
    self.key = self.key.parameterize.underscore if self.key.present?
  end

  def as_json
      {
          name: name,
          type: type,
          is_filter_exist: is_filter_exist,
          is_sort_exist: is_sort_exist
      }
  end
end
```

PeopleController.rb

```ruby
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
```
