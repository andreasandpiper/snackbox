module Admin
  class ExchangesController < ApplicationController
    http_basic_authenticate_with :name => "user", :password => "password" 
  
    def index
      @exchanges = Exchange.all
    end

    def new
    end

    def create
      exchange = Exchange.new params.permit(:name, :start_date, :end_date, :country, :details, :department)
      exchange.save
      redirect_to admin_exchanges_path
    end
  end
end