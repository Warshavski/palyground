# frozen_string_literal: true

class CreatePublishers < ActiveRecord::Migration[7.0]
  def change
    create_table :publishers do |t|
      t.string :name, null: false
      t.string :email
      t.string :phone
      t.string :address
      t.string :postcode

      t.timestamps
    end
  end
end
