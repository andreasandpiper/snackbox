class ParticipationMailer < ApplicationMailer
  def edit_participation
    @url = "/exchanges/#{params[:exchange_id]}/participations/#{params[:participation].id}"
    mail(to: params[:participation].user.email, subject: 'SnackBox Link to edit participation for exchange')
  end
end
