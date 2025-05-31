# frozen_string_literal: true

class RemoveUserReferencesAndUsersTable < ActiveRecord::Migration[7.0]
  def change
    # orders テーブルから user_id を削除
    remove_reference :orders, :user, foreign_key: true

    # carts テーブルから user_id を削除
    remove_reference :carts, :user, foreign_key: true

    # promotion_codes テーブルから user_id を削除
    remove_reference :promotion_codes, :user, foreign_key: true

    # users テーブルを削除
    drop_table :users do |t|
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.boolean :system_account, default: false, null: false
      t.timestamps

      t.index :email, unique: true
      t.index :reset_password_token, unique: true
    end
  end
end
