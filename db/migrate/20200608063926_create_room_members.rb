class CreateRoomMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :room_members do |t|
      t.integer :room_id
      t.integer :user_id

      t.timestamps
    end
  end
end
