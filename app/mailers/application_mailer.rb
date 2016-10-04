class ApplicationMailer < ActionMailer::Base

  # Override de la methode mail pour sauvegarder automatiquement dans la base
  def mail_remerciement(destinataire)

    Mailjet.configure do |config|
      config.api_key = ENV['MJ_APIKEY_PUBLIC']
      config.secret_key = ENV['MJ_APIKEY_PRIVATE']
      config.default_from = 'contact@ajpourlafrance.fr'
    end

    # Body
    content_text  = 'Chère amie, cher ami,\n \\'
    content_text += '\n'
    content_text += 'Nous avons bien reçu votre don. Merci pour votre soutien.\n'
    content_text += '\n'
    content_text += 'Seuls vos dons rendent possible la candidature d\'Alain Juppé à la primaire de la droite et du centre les 20 et 27 novembre 2016.\n'
    content_text += 'A ce titre, nous vous remercions très chaleureusement pour votre action.\n'
    content_text += 'Si d\'autres personnes de votre entourage peuvent contribuer à la campagne d\'Alain Juppé, n\'hésitez pas à leur transmettre le lien http://don.alainjuppe2017.fr.\n'
    content_text += '\n'
    content_text += 'Ensemble, construisons la France de demain.\n'
    content_text += 'Avec toute notre gratitude,\n'
    content_text += '\n'
    content_text += 'L\'équipe nationale Alain Juppé 2017'

    content_html  = '<p>Chère amie, cher ami,</p>'
    content_html += '<br/>'
    content_html += '<p>Nous avons bien reçu votre don. Merci pour votre soutien.</p>'
    content_html += '<br/>'
    content_html += '<p>Seuls vos dons rendent possible la candidature d\'Alain Juppé à la primaire de la droite et du centre les 20 et 27 novembre 2016.</p>'
    content_html += '<p>A ce titre, nous vous remercions très chaleureusement pour votre action.</p>'
    content_html += '<p>Si d\'autres personnes de votre entourage peuvent contribuer à la campagne d\'Alain Juppé, n\'hésitez pas à leur transmettre le lien <a href="http://don.alainjuppe2017.fr">http://don.alainjuppe2017.fr</a>.</p>'
    content_html += '<br/>'
    content_html += '<p>Ensemble, construisons la France de demain.</p>'
    content_html += '<p>Avec toute notre gratitude,</p>'
    content_html += '<br/>'
    content_html += '<p>L\'équipe nationale Alain Juppé 2017</p>'

    Mailjet::Send.create(
        from_email: "contact@ajpourlafrance.fr",
        from_name: "Equipe de campagne d\'Alain Juppé",
        subject: "ANFCAPAJ - Merci pour votre don",
        text_part: content_text,
        html_part: content_html,
        to: destinataire,
        bcc: 'malayeddine@alainjuppe2017.fr'
    )

  end
end
