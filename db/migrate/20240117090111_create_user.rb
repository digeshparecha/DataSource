# frozen_string_literal: true

class CreateUser < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :uuid
      t.integer :gender
      t.jsonb :name
      t.jsonb :location
      t.integer :age

      t.timestamps
    end
  end
end
