# frozen_string_literal: true

class ParticipationMailer < ApplicationMailer
  def edit_participation
    new_token = token(params[:participation].id)
    @url = "#{ENV.fetch("BASE_URL")}/exchanges/#{params[:exchange_id]}/participations/#{params[:participation].id}/edit?token=#{new_token}"
    mail(to: params[:participation].user.email, subject: 'SnackBox | Link to edit details')
  end

  def verify_participation
    new_token = token(params[:participation].id)
    @participant = params[:participation]
    @verify_url = "#{ENV.fetch("BASE_URL")}/exchanges/#{params[:exchange_id]}/participations/#{params[:participation].id}/verify"
    @edit_url = "#{ENV.fetch("BASE_URL")}/exchanges/#{params[:exchange_id]}/participations/#{params[:participation].id}/edit?token=#{new_token}"
    mail(to: params[:participation].user.email, subject: 'SnackBox | Verify your email')
  end

  private

  def token(id)
    new_token = SecureRandom.alphanumeric(6)
    current_token = ParticipationToken.find_by participation_id: id
    if current_token
      current_token.update token: new_token, expires_at: Time.now + 1.day
    else
      ::ParticipationToken.create token: new_token, participation_id: id,
                                  expires_at: Time.now + 1.day
    end
    new_token
  end
end
