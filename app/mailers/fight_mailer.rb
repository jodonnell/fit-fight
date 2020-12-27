class FightMailer < ApplicationMailer

  def fight_email player1, player2, output
    mail(to: player1.email, subject: 'Fight results') do
      render plain: output
    end
  end
end
