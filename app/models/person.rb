class Person < ApplicationRecord

  ## HSTORE
  # person.metadata = { number: '100', data: { nested_data: { value: 100 } }}
  # Person.order("metadata -> 'number' DESC")

  # Person.search({s:['metadata_number DESC']}).result
  # Does not support
  # Person.search({metadata_number_gteq: '100'}).result
  # ransacker :metadata_number do |parent|
  #   Arel::Nodes::InfixOperation.new('->', parent.table[:metadata], Arel::Nodes.build_quoted('number'))
  # end

  ## JSONB
  # Person.create(preferences: { number: 100 })
  # Person.search({preferences_number_gt: 1}).result
  # Person.search({s: ['preferences_number DESC']}).result
  # ransacker :preferences_number do |parent|
  #   Arel::Nodes::InfixOperation.new('->>', parent.table[:preferences], Arel::Nodes.build_quoted('number'))
  # end
  # ransacker :preferences_number_int do
  #   Arel.sql("(preferences ->> 'number')::int")
  # end

  # Person.create(preferences: { number: 100, metadata: { numbers: { value: 100 } }})
  # Person.search({preferences_metadata_numbers_value_gt: 1}).result
  # Person.search({s: ['preferences_metadata_numbers_value DESC']}).result
  # Person.where("preferences -> 'metadata' -> 'numbers' ->> 'value' >= '100'")
  # ransacker :preferences_metadata_numbers_value do |parent|
  #   Arel::Nodes::InfixOperation.new( '->>',
  #     Arel::Nodes::InfixOperation.new('->',
  #       Arel::Nodes::InfixOperation.new('->', parent.table[:preferences], Arel::Nodes.build_quoted('metadata')),
  #     Arel::Nodes.build_quoted('numbers')
  #     ),
  #     Arel::Nodes.build_quoted('value')
  #   )
  # end

end
