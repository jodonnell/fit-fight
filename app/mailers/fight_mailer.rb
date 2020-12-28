class FightMailer < ApplicationMailer

  def fight_email player1, player2, output
    @output = output.html_safe
    mail(to: [player1.email, player2.email], subject: 'Fight results')
  end
end
