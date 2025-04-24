# frozen_string_literal: true

class AddSystemAccountToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :system_account, :boolean, default: false, null: false
  end
end
