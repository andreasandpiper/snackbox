# frozen_string_literal: true

class ExchangeMailer < ApplicationMailer
  def send_matching
    @exchange = params[:exchange]
    @exchange.matched_participants.each do |r|
      @participant = r
      @match = r.match
      mail(to: @participant.user.email,
           subject: 'SnackBox | Let the snacking begin! Checkout your snack match!').deliver
    end
  end

  def send_reminder
    @exchange = params[:exchange]
    @exchange.participation.each do |r|
      @participant = r
      random_token = SecureRandom.alphanumeric(6)
      ::ParticipationToken.create token: random_token, participation_id: @participant.id,
                                  expires_at: Time.now + 1.day
      @url = "#{ENV.fetch("BASE_URL")}/exchanges/#{@exchange.id}/participations/#{@participant.id}/edit?token=#{random_token}"
      mail(to: @participant.user.email,
           subject: 'SnackBox | Matching is happening soon, make sure your information is correct!').deliver
    end
  end
end
