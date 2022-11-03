class AddAttachmentsToUserDependency < ActiveRecord::Migration[7.0]
  def change
    add_reference :attachments, :owner, null: false, foreign_key: { to_table: :users }
  end
end
