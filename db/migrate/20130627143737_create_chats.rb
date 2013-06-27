class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.string :message
      t.string :from
      t.string :to

      t.timestamps
    end
  end
end
