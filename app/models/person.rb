class Person < ActiveRecord::Base

  OFFSET = 155326

  def self.find_by_order_id(order_id)
    find_by(id: order_id.to_i - OFFSET)
  end

  validates :first_name,  presence: true
  validates :last_name,   presence: true
  validates :email,       presence: true
  validates :address,     presence: true
  validates :city,        presence: true
  validates :zip_code,    presence: true
  validates :phone,       presence: true

  def order_id
    id + OFFSET
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def donation_status
    case status
      when 0
        'Incomplet ou invalide'
      when 1
        'Annulé par le donateur'
      when 2
        'Refusé par l\'établissement bancaire'
      when 5
        'Autorisé'
      when 51
        'Autorisation en attente'
      when 52
        'Autorisation incertaine'
      when 61
        'Annulation d\'autorisation en attente'
      when 62
        'Annulation d\'autorisation incertaine'
      when 63
        'Annulation d\'autorisation refudée'
      when 7
        'Don annulé'
      when 71
        'Annulation en attente'
      when 8
        'Don remboursé'
      when 81
        'Remboursement du don en attente'
      when 9
        'Don finalisé'
      when 91
        'Capture du don en cours'
      when 92
        'Capture du don incertain'
      when 93
        'Capture du don refusé'
      when nil
        'En attente'
      else
        raise "Statut indéterminé #{status}"
    end
  end
end