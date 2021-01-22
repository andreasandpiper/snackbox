# frozen_string_literal: true

class ExchangeMailer < ApplicationMailer
  def send_matching
    mail(to: params[:participation].user.email,
         subject: 'SnackBox | Let the snacking begin! Checkout your snack match!')
  end
end
