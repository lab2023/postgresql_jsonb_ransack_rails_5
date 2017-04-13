class AddMetadataToPerson < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'citext'
    add_column :people, :metadata, :jsonb, null: false, default: '{}'
    add_index  :people, :metadata, using: :gin
  end
end
