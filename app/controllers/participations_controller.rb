# frozen_string_literal: true

class ParticipationsController < ApplicationController
  def new
    @exchange = Exchange.find params[:exchange_id]
    @participation = Participation.new
    @user = User.new
  end

  def edit
    @exchange = Exchange.find params[:exchange_id]
  end

  def create
    @exchange = Exchange.find params[:exchange_id]
    @user = User.find_or_create_by user_params
    @participation = @user.participation.new participation_params.merge(exchange_params)
    if @participation.valid?
      @participation.save
      flash.now[:notice] =
        "You've successfully signed up for '#{@exchange[:name].capitalize}' exchange! Matching occurs on #{@exchange[:start_date]}.'"
      render :edit
    else
      flash.now[:alert] = @participation.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @exchange = Exchange.find params[:exchange_id]
    @participation = @exchange.participation.find params[:id]
  end

  def edit_link
    # TODO: why are flashes and redirect not working?
    @exchange = Exchange.find params[:exchange_id]
    @participation = Participation.new
    @user = User.find_by email: params[:email]
    if @user.nil?
      flash[:alert] = 'You have not signed up for the exchange.'
      render :new
    else
      participation = @user.participation.find_by exchange_id: params[:exchange_id]
      if participation
        ParticipationMailer.with(participation: participation,
                                 exchange_id: params[:exchange_id]).edit_participation.deliver_now
        flash[:notice] = "Email sent to #{params[:email]}"
      else
        flash[:alert] = 'You have not signed up for the exchange.'
        render :new
      end
    end
  end

  private

  def participation_params
    params.require(:participation).permit(:full_name, :address_1, :address_2, :city, :state, :zipcode, :country,
                                          :preferences, :team)
  end

  def exchange_params
    params.permit(:exchange_id)
  end

  def user_params
    params.permit(:email)
  end
end
