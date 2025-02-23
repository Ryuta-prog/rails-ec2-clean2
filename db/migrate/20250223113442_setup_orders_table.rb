# frozen_string_literal: true

class SetupOrdersTable < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :total, precision: 10, scale: 2
      t.string :billing_address
      t.string :state
      t.string :zip
      t.timestamps
    end
  end
end
