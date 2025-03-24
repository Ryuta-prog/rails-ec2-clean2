# frozen_string_literal: true

class CreateActiveStorageTables < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'plpgsql' unless extension_enabled?('plpgsql')

    unless table_exists?(:active_storage_blobs)
      create_table :active_storage_blobs do |t|
        t.string   :key,          null: false
        t.string   :filename,     null: false
        t.string   :content_type
        t.text     :metadata
        t.string   :service_name, null: false
        t.bigint   :byte_size,    null: false
        t.string   :checksum
        t.datetime :created_at, null: false
        t.index [:key], unique: true
      end
    end

    return if table_exists?(:active_storage_attachments)

    create_table :active_storage_attachments do |t|
      t.string     :name,         null: false
      t.references :record,       null: false, polymorphic: true, index: false
      t.references :blob,         null: false
      t.datetime   :created_at,   null: false
      t.index %i[record_type record_id name blob_id], name: :active_storage_attachments_uniqueness, unique: true
      t.foreign_key :active_storage_blobs, column: :blob_id
    end
  end
end
