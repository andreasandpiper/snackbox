class ParticipationsController < ApplicationController
    
    def new
        @exchange = Exchange.find params[:exchange_id]
        @participation = Participation.new
        @user = User.new
    end

    def edit
        @exchange = Exchange.find params[:exchange_id]
    end

    def create
        byebug
        @exchange = Exchange.find params[:exchange_id]
        @user = User.find_or_create_by user_params
        @participation = @user.participation.new participation_params.merge(exchange_params)
        if @participation.valid?
            @participation.save
            flash.now[:notice] = "You've successfully signed up for '#{@exchange[:name].capitalize}' exchange! Matching occurs on #{@exchange[:start_date]}.'"
            render :edit
        else
            flash.now[:error] = @participation.errors.full_messages.to_sentence
            render :new
        end
    end

    private

    def participation_params
        params.require(:participation).permit(:full_name, :address_1, :address_2, :city, :state, :zipcode, :country, :preferences, :team)
    end

    def exchange_params
        params.permit(:exchange_id)
    end

    def user_params
        params.permit(:email)
    end
end