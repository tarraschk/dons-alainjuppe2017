class Person < ActiveRecord::Base

  def self.find_by_order_id(order_id)
    find_by(id: order_id - 155326)
  end

  validates :first_name,  presence: true
  validates :last_name,   presence: true
  validates :email,       presence: true
  validates :address,     presence: true
  validates :city,        presence: true
  validates :zip_code,    presence: true
  validates :phone,       presence: true

  def order_id
    id + 155326
  end
end