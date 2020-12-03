class ParticipationsController < ApplicationController
    
    def new
        @exchange = Exchange.find params[:exchange_id]
        @participation = Participation.new
    end

    def create
        @user = User.find_or_create_by user_params
        if @user.errors.any?
            render :new
        else 
            @user.participation.new participation_params.merge(exchange__params)
            if @user.participation
                @user.participation.save
                redirect_to exchange_path(params[:exchange_id])
            else
                render :new
            end
        end

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