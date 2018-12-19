class AirlinesController < ApplicationController

  def create
    @airline = Airline.create(name: params[:name])
  end
end
