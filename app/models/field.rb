class Field
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

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