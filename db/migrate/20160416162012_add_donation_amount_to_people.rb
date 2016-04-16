class AddDonationAmountToPeople < ActiveRecord::Migration
  def change
    add_column :people, :donation_amount, :integer
  end
end
