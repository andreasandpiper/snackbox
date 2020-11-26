class ParticipationsController < ApplicationController
    
    def new
        @exchange = Exchange.find params[:exchange_id]
        @participation = Participation.new
    end

    def create
        user = User.find_or_create_by user_params
        byebug
        user.participation.create participation_params.merge(exchange__params)

        redirect_to exchange_path(params[:exchange_id])
    end


    private

    def participation_params
        params.require(:participation).permit(:full_name, :address_1, :address_2, :city, :state, :zipcode, :country, :preferences, :team)
    end

    def exchange__params
        params.permit(:exchange_id)
    end

    def user_params
        params.require(:participation).permit(:email)
    end
end