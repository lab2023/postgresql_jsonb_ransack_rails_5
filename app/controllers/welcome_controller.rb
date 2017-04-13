class WelcomeController < ApplicationController
  def index_one
    @user = User.first
    set_person_ransackers(@user)
    @search = Person.search(params[:q])
    @people = @search.result
  end

  def index_second
    @user = User.second
    set_person_ransackers(@user)
    @search = Person.search(params[:q])
    @people = @search.result
  end

  private

  def set_person_ransackers(user)
    @fields = user.fields['person']
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
