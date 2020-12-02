module Admin
  class ExchangesController < ApplicationController
    http_basic_authenticate_with :name => "user", :password => "password" 
  
    def index
      @exchanges = Exchange.all
    end

    def show
      @exchange = Exchange.find params[:id]
      @participation = @exchange.participation.joins(:user)
    end

    def new
      @exchange = Exchange.new
    end

    def create
      exchange = Exchange.new exchange_params.merge(exchange_date_params)
      exchange.save
      redirect_to admin_exchanges_path
    end

    def edit
      @exchange = Exchange.find params[:id]
    end

    def update
      exchange = Exchange.find params[:id]
      exchange.update! exchange_params.merge(exchange_date_params)
      redirect_to admin_exchanges_path
    end

    private

    def exchange_params
      params.require(:exchange).permit(:name, :country, :details, :department)
    end

    def exchange_date_params
      formated_end_date = format_date("start_date")
      formated_start_date = format_date("end_date")
      return { end_date: formated_end_date, start_date: formated_start_date }
    end

    def format_date(key)
      hash = params.require(:exchange)
      Date.new *%w(1 2 3).map { |e| hash["#{key}(#{e}i)"].to_i }
    end
  end
end