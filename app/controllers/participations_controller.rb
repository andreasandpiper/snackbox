# frozen_string_literal: true

class ParticipationsController < ApplicationController
  before_action :check_valid_token, only: %i[edit update destroy]

  def new
    @exchange = Exchange.find params[:exchange_id]
    @participation = Participation.new
    @user = User.new
    if params[:email]
      @user.email = params[:email]
    end
  end

  def edit
    @exchange = Exchange.find params[:exchange_id]
    @participation = @exchange.participation.find params[:id]
    @user = @participation.user
    @token = params[:token]
  end

  def update
    @participation = Participation.find params[:id]
    @exchange = @participation.exchange
    @user = User.find_or_create_by email: params[:email].downcase.strip
    @token = params[:token]
    if @participation.update participation_params.merge(exchange_params)
      flash.now[:notice] = "You've successfully updated your preferences!"
      render :edit
    else
      flash.now[:alert] = @participation.errors.full_messages.to_sentence
      render :edit
    end
  end

  def create
    @exchange = Exchange.find params[:exchange_id]
    @user = User.find_or_create_by email: params[:email].downcase.strip
    @participation = @user.participation.new participation_params.merge(exchange_params)
    if @participation.valid?
      @participation.save
      @token = @participation.generate_token
      ParticipationMailer.with(participation: @participation,
        exchange_id: @exchange.id, token: @token).verify_participation.deliver_now
      flash[:notice] =
        "You've successfully signed up for '#{@exchange[:name].capitalize}' exchange! Look for an email to verify your sign up!"
      render :edit
    else
      flash.now[:alert] = @participation.errors.full_messages.concat(@user.errors.full_messages).join(", ")
      render :new
    end
  end

  def destroy
    participation = Participation.find params[:id]
    if participation.destroy
      flash[:alert] = "You've been removed from participating in the exchange."
      redirect_to exchanges_path
    else
      @exchange = @participation.exchange
      @user = @participation.user
      flash.now[:alert] = @participation.errors.full_messages.to_sentence
      render :edit
    end
  end

  def edit_link
    @exchange = Exchange.find params[:exchange_id]
    @participation = Participation.new
    @user = User.find_by email: params[:email].downcase.strip
    if @user.present?
      participation = @user.participation.find_by exchange_id: params[:exchange_id]
      if participation
        ParticipationMailer.with(participation: participation,
                                  exchange_id: params[:exchange_id]).edit_participation.deliver_now
        flash[:notice] = "Email sent to #{params[:email]}. The link will expire in 24 hours."
        respond_to do |format|
          format.js { render js: "window.location.href = '#{exchange_path(@exchange)}'" }
        end
        return
      end
    end
    flash[:alert] = 'You have not signed up for the exchange, fill out the form below to sign up!'
    respond_to do |format|
      format.js { render js: "window.location.href = '#{new_exchange_participation_path(@exchange)}?email=#{params[:email]}'" }
    end
  end

  def verify
    participation = Participation.find params[:id]
    if participation.update verified_email: true
      flash[:notice] = "Successfully verified email for #{participation.user[:email]}"
    else
      flash[:alert] = "Not able to verify email for #{participation.user[:email]}. Please contact for assistance."
    end
    redirect_to exchange_url(participation.exchange)
  end

  private

  def check_valid_token
    valid_token = ParticipationToken.where("token = ? AND participation_id = ? AND expires_at >= ?", params[:token], params[:id], Time.now )
    unless valid_token.present?
      flash[:alert] = 'This link has expired. Please submit email address below to receive a new link.'
      redirect_to exchange_path(Exchange.find params[:exchange_id])
    end
  end

  def participation_params
    params.require(:participation).permit(:full_name, :address_1, :address_2, :city, :state, :zipcode, :country,
                                          :preferences, :team)
  end

  def exchange_params
    params.permit(:exchange_id)
  end
end
