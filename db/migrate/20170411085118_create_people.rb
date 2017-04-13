class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :surname
      t.integer :age
      t.string :email

      t.timestamps
    end
  end
end
