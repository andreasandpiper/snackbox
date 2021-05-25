# frozen_string_literal: true

module Admin
  class ExchangesController < ApplicationController
    http_basic_authenticate_with name: Rails.application.credentials.admin_login_username, password: Rails.application.credentials.admin_login_password

    def index
      @exchanges = Exchange.all.most_current_first
    end

    def show
      @exchange = Exchange.find params[:id]
      @participation = @exchange.participants
    end

    def new
      @exchange = Exchange.new
    end

    def create
      @exchange = Exchange.new exchange_params.merge(exchange_date_params)
      if @exchange.save
        redirect_to admin_exchanges_path
      else
        render :new
      end
    end

    def edit
      @exchange = Exchange.find params[:id]
    end

    def update
      @exchange = Exchange.find params[:id]
      @exchange.update! exchange_params.merge(exchange_date_params)
      redirect_to admin_exchange_url(@exchange)
    end

    def match
      @exchange = Exchange.find params[:id]
      @exchange.participation.update_all is_matched: false, match_participation_id: nil
      matcher = ParticipationMatcher.new @exchange
      matcher.match
      matcher.order_match unless matcher.complete
      @participation = @exchange.participants
      render :show
    end

    def deliver_matches
      @exchange = Exchange.find params[:id]
      ExchangeMailer.with(exchange: @exchange).send_matching.deliver_later
      @exchange.update mailed_matches: true
      flash[:notice] = "Successfully mailed out matches!"
      redirect_to admin_exchange_url(@exchange)
    end

    def send_reminder
      @exchange = Exchange.find params[:id]
      ExchangeMailer.with(exchange: @exchange).send_reminder.deliver_later
      flash[:notice] = "Successfully mailed out reminder!"
      redirect_to admin_exchange_url(@exchange)
    end

    def set_exclude
      @exchange = Exchange.find params[:id]
      participation = Participation.find params[:participation_id]
      participation.update exclude: ActiveModel::Type::Boolean.new.cast(!!params[:exclude])
      flash[:notice] = "Successfully updated exclusion for participant #{participation.id}"
      redirect_to admin_exchange_url(@exchange)
    end

    private

    def exchange_params
      params.require(:exchange).permit(:name, :country, :details, :department, :teams)
    end

    def exchange_date_params
      formated_signup_date = format_date('signup_date')
      formated_ship_date = format_date('ship_date')
      formated_match_date = format_date('match_date')
      { ship_date: formated_ship_date, signup_date: formated_signup_date, match_date: formated_match_date }
    end

    def format_date(key)
      hash = params.require(:exchange)
      Date.new(*%w[1 2 3].map { |e| hash["#{key}(#{e}i)"].to_i })
    end
  end
end
