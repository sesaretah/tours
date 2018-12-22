class ReservationsController < ApplicationController
  def new
    @reservation = Reservation.new
    @tour = Tour.find(params[:tour_id])
  end

  def create

  end
end
