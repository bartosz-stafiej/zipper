# frozen_string_literal: true

class RemoveUselessAttachmentsColumns < ActiveRecord::Migration[7.0]
  def change
    change_table(:attachments) do |t|
      t.remove :size, type: :int
      t.remove :expires_at, type: :timestamp
      t.remove :name, type: :string
    end
  end
end
