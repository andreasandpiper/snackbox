module Admin
  class ExchangesController < ApplicationController
    http_basic_authenticate_with :name => "user", :password => "password" 
  
    def index
    end
  end
end