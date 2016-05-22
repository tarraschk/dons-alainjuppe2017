class OgoneNotification < ActiveRecord::Base

  after_save :apply
  def person
    @person ||= Person.find_by_order_id(order_id)
  end

  def apply

  end
end
