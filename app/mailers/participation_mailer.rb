# frozen_string_literal: true

class ParticipationMailer < ApplicationMailer
  def edit_participation
    new_token = params[:participation].generate_token
    @url = "#{Rails.application.credentials.base_url}/exchanges/#{params[:exchange_id]}/participations/#{params[:participation].id}/edit?token=#{new_token}"
    mail(to: params[:participation].user.email, subject: 'SnackBox | Link to edit details')
  end

  def verify_participation()
    @participant = params[:participation]
    @verify_url = "#{Rails.application.credentials.base_url}/exchanges/#{params[:exchange_id]}/participations/#{params[:participation].id}/verify"
    @edit_url = "#{Rails.application.credentials.base_url}/exchanges/#{params[:exchange_id]}/participations/#{params[:participation].id}/edit?token=#{params[:token]}"
    mail(to: params[:participation].user.email, subject: 'SnackBox | Verify your email')
  end
end
