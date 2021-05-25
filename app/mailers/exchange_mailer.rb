# frozen_string_literal: true

class ExchangeMailer < ApplicationMailer
  def send_matching
    @participant = params[:participation]
    mail(to: @participant.user.email,
      subject: 'SnackBox | Let the snacking begin! Here is your snack match!')
  end

  def send_reminder
    @participant = params[:participation]
    random_token = SecureRandom.alphanumeric(6)
    ::ParticipationToken.create token: random_token, participation_id: @participant.id,
      expires_at: Time.now + 1.day
    @url = "#{Rails.application.credentials.base_url}/exchanges/#{@participant.exchange.id}/participations/#{@participant.id}/edit?token=#{random_token}"
    @verify_url = "#{Rails.application.credentials.base_url}/exchanges/#{@participant.exchange.id}/participations/#{@participant.id}/verify?token=#{random_token}"
    mail(to: @participant.user.email,
      subject: 'SnackBox | Matching is happening soon, make sure your information is correct!')
  end
end
