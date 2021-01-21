# frozen_string_literal: true

class ParticipationsController < ApplicationController
  before_action :check_valid_token, only: %i[edit delete]

  def new
    @exchange = Exchange.find params[:exchange_id]
    @participation = Participation.new
    @user = User.new
  end

  def edit
    @exchange = Exchange.find params[:exchange_id]
    @participation = @exchange.participation.find params[:id]
    @user = @participation.user
  end

  def update
    @participation = Participation.find params[:id]
    @exchange = @participation.exchange
    @user = @participation.user
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
    @user = User.find_or_create_by user_params.downcase
    @participation = @user.participation.new participation_params.merge(exchange_params)
    if @participation.valid?
      @participation.save
      flash[:notice] =
        "You've successfully signed up for '#{@exchange[:name].capitalize}' exchange! Matching occurs on #{@exchange[:start_date]}. You will get an email with your matchers information. In order to edit your preferences, you will need a new sign up link sent to you."
      redirect_to exchanges_path
    else
      flash.now[:alert] = @participation.errors.full_messages.to_sentence
      render :new
    end
  end

  def delete
    byebug
  end

  def edit_link
    # TODO: why are flashes and redirect not working?
    @exchange = Exchange.find params[:exchange_id]
    @participation = Participation.new
    @user = User.find_by email: params[:email].downcase
    if @user.nil?
      flash[:alert] = 'You have not signed up for the exchange, sign up below.'
      @user = User.new
      respond_to do |format|
        format.js { render js: "window.location.href = '#{new_exchange_participation_path(@exchange)}'" }
      end
    else
      participation = @user.participation.find_by exchange_id: params[:exchange_id]
      if participation
        ParticipationMailer.with(participation: participation,
                                 exchange_id: params[:exchange_id]).edit_participation.deliver_now
        # flash not working
        flash.now[:notice] = "Email sent to #{params[:email]}"
      else
        flash[:alert] = 'You have not signed up for the exchange.'
        respond_to do |format|
          format.js { render js: "window.location.href = '#{new_exchange_participation_path(@exchange)}'" }
        end
      end
    end
  end

  private

  def check_valid_token
    valid_token = ParticipationToken.find_by token: params[:token], participation_id: params[:id]
    unless valid_token
      flash[:error] = 'This link has expired. Please re-submit email address to get a new link.'
      redirect_to exchanges_path
    end
  end

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
