# frozen_string_literal: true

class CreateInitialSchema < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      t.timestamps null: false
    end

    add_index :users, :email, unique: true

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
