class UsersController < ApplicationController
  before_action :set_user
  before_action :set_person_ransackers, only: :show

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to @user
  end

  def show
    @search = Person.search(params[:q])
    @people = @search.result
  end

  private

    def user_params
      params.require(:user).permit(:name)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def set_person_ransackers
      @fields = @user.fields['person']
      return unless @fields.present?
      @fields.keys.each do |key|
        ransack_help(key)
      end
    end

    def ransack_help(type)
      Person.class_eval do
        Rails.logger.warn "Ransacker initialized for #{type.upcase}".red
        ransacker "metadata_#{type}".to_sym do |parent|
          Arel::Nodes::InfixOperation.new('->>', parent.table[:metadata], Arel::Nodes.build_quoted(type))
        end
      end
    end

end
