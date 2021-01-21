# frozen_string_literal: true

class ParticipationMailer < ApplicationMailer
  def edit_participation
    random_token = SecureRandom.alphanumeric(6)
    current_token = ParticipationToken.find_by participation_id: params[:participation].id
    if current_token
      current_token.update token: random_token, expires_at: Time.now + 1.day
    else
      ::ParticipationToken.create token: random_token, participation_id: params[:participation].id,
                                  expires_at: Time.now + 1.day
    end
    @url = "/exchanges/#{params[:exchange_id]}/participations/#{params[:participation].id}/edit?token=#{random_token}"
    mail(to: params[:participation].user.email, subject: 'SnackBox Link to edit participation for exchange')
  end
end
