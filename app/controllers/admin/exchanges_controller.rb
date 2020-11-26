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
      exchange = Exchange.new exchange_params
      exchange.save
      redirect_to admin_exchanges_path
    end

    def edit
      @exchange = Exchange.find params[:id]
    end

    def update
      exchange = Exchange.find params[:id]
      exchange.update! exchange_params
      redirect_to admin_exchanges_path
    end

    private

    def exchange_params
      params.require(:exchange).permit(:name, :start_date, :end_date, :country, :details, :department)
    end
  end
end