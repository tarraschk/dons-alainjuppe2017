class Person < ActiveRecord::Base

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