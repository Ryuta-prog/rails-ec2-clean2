# frozen_string_literal: true

class AddPublishedToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :published, :boolean, default: true, null: false
  end
end
