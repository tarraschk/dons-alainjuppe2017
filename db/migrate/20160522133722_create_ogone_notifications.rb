class CreateOgoneNotifications < ActiveRecord::Migration
  def change
    create_table :ogone_notifications do |t|
      t.integer :order_id
      t.text :message

      t.timestamps null: false
    end
  end
end
