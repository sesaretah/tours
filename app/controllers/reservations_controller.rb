class ReservationsController < ApplicationController

  def passengers
    @tour = Tour.find(params[:tour_id])
  end
  def new
    @reservation = Reservation.new
    @tour = Tour.find(params[:tour_id])
  end

  def create

  end
end
