class AddPaymentInformationToPerson < ActiveRecord::Migration
  def change
    add_column :people, :donation_type, :string
    add_column :people, :donation_status, :string
    add_column :people, :civility, :string
  end
end
