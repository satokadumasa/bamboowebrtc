class CreateUserInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :user_infos do |t|
      t.integer :user_id
      t.string :name
      t.string :mobile
      t.integer :pref_id
      t.string :postal_code
      t.string :address

      t.timestamps
    end
  end
end
