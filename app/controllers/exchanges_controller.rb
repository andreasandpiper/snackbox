# frozen_string_literal: true

class ExchangesController < ApplicationController
  def index
    flash.keep
    @exchanges = Exchange.where('ship_date >= ?', Date.today)
  end

  def show
    @exchange = Exchange.find params[:id]
  end
end
