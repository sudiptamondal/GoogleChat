class AddMessageReadToChat < ActiveRecord::Migration
  def change
    add_column :chats, :message_read, :boolean
  end
end
