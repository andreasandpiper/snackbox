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
end
