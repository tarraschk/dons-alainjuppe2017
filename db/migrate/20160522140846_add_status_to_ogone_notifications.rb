class AddStatusToOgoneNotifications < ActiveRecord::Migration
  def change
    add_column :ogone_notifications, :status, :integer
    add_column :people, :status, :integer
  end
end
