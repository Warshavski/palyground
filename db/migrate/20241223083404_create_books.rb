# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.integer :weight, default: 0, null: false
      t.integer :pages_count, default: 0, null: false
      t.text :description
      t.string :isbn13, limit: 13
      t.string :isbn10, limit: 10
      t.date :published_in, null: false
      t.belongs_to :publisher, null: false, foreign_key: true

      t.timestamps
    end
    create_join_table :books, :authors
  end
end
