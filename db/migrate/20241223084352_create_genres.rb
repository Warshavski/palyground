# frozen_string_literal: true

class CreateGenres < ActiveRecord::Migration[7.0]
  def change
    create_table :genres do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
    create_join_table :books, :genres
  end
end
