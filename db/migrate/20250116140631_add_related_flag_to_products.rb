# frozen_string_literal: true

class AddRelatedFlagToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :is_related, :boolean, default: false, null: false
  end
end
