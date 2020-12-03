# frozen_string_literal: true

class ExchangesController < ApplicationController
  def index
    @exchanges = Exchange.where('end_date >= ?', Date.today)
  end

  def show
    @exchange = Exchange.find params[:id]
  end
end
